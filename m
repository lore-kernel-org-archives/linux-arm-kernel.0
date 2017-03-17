From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 15:04:12 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <1489759373.17202.44.camel@infradead.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
Message-ID: <20170317150411.GH5940@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 02:02:53PM +0000, David Woodhouse wrote:
> On Fri, 2017-03-17 at 11:43 +0000, David Woodhouse wrote:
> > 
> > Is this one going to be be my fault too?
> 
> Looks like it isn't my fault. In ipi_cpu_crash_stop() we don't modify
> the online mask. Which is reasonable enough if we want to preserve its
> original contents from before the crash, but it does make that
> WARN_ON() in machine_kexec() a false positive.
> 
> Btw, why is this a normal IPI and not something... less maskable?
> On x86 we use NMI for that...

Architecturally, arm64 does not have an NMI.

There's been some work to try to get pseudo-NMIs using GICv3 priorities,
but that's about the closest we can get today.

Thanks,
Mark.
