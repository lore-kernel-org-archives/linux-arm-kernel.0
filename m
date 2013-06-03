From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 3 Jun 2013 17:33:45 -0400 (EDT)
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <51AD0703.6050408@codeaurora.org>
References: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
 <5193E424.9090605@codeaurora.org> <519E57D2.3050000@codeaurora.org>
 <20130523231531.GT18614@n2100.arm.linux.org.uk>
 <20130524220539.GB599@codeaurora.org> <51AD0703.6050408@codeaurora.org>
Message-ID: <alpine.LFD.2.03.1306031726410.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 05/24/13 15:05, Stephen Boyd wrote:
> > I see a few solutions.
> >
> >  1) Relocate with caches off and then turn on caches after we're
> >     running in a location where we won't overwrite ourselves.

Due to the cost of doing memory copy with the cache off, thisoption 
should be conditionally used and only when there is an actual conflict.

> >  2) Have temporary page tables for the relocation phase that live
> >     just below the location we're going to relocate to.
> >
> >  3) Force bootloaders loading these types of images to load the
> >     zImage at least as high as the TEXT_OFFSET is compiled to.
> >
> > I don't think we can convince everyone that #3 is ok to do. I'm
> > leaning towards #2 since we get all the benefits of the cache
> > during the relocation phase but #1 is the obviously simple fix.

I'd consider #2 too.


Nicolas
