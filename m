From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Nov 2012 10:40:07 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <50A163C6.6080208@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121112102354.GA2346@mudshark.cambridge.arm.com>
 <50A105E7.6000005@gmail.com>
 <20121112144122.GJ2346@mudshark.cambridge.arm.com>
 <20121112165117.GB18863@mudshark.cambridge.arm.com>
 <50A163C6.6080208@gmail.com>
Message-ID: <20121113104006.GC3940@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:01:58PM +0000, Rob Herring wrote:
> On 11/12/2012 10:51 AM, Will Deacon wrote:
> > Ok, similar numbers over here so it looks like this is definitely worth
> > doing. However, I still object to the "cc", particularly after discussion
> > with the tools guys here who agree that the behaviour you're seeing is
> > indicative of a buggy compiler. It may even be part of a larger issue with
> > GCC's definition of `reachability' for kernel entry points. For interest, I
> > failed to reproduce with:
> > 
> >   gcc version 4.7.3 20121001 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2012.10-20121022 - Linaro GCC 2012.10)
> > (http://launchpad.net/linaro-toolchain-binaries/trunk/2012.10/+download/gcc-linaro-arm-linux-gnueabihf-4.7-2012.10-20121022_linux.tar.bz2)
> > 
> > which sounds fairly close to the tools that you are using. Please can you
> > file a bug in launchpad? 
> 
> Strangely, I can't reproduce it either now...

Reproduce what? :)

If you remove the "cc" clobber, you can add my ack:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
