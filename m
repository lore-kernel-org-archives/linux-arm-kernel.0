From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 23 Sep 2014 11:46:56 +0100
Subject: [PATCH] arm64, defconfig: Increase NR_CPUS default to 64
In-Reply-To: <20140923104431.GF20170@rric.localhost>
References: <1410176689-20020-1-git-send-email-rric@kernel.org>
 <20140923104431.GF20170@rric.localhost>
Message-ID: <20140923104656.GA24822@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Tue, Sep 23, 2014 at 11:44:31AM +0100, Robert Richter wrote:
> On 08.09.14 13:44:48, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > Raising the current maximum limit to 64. This is needed for Cavium's
> > Thunder systems that will have at least 48 cores per die.
> > 
> > The change keeps the current memory footprint in cpu mask structures.
> > It does not break existing code. Setting the maximum to 64 cpus still
> > boots systems with less cpus.
> > 
> > Mark's Juno happily booted with a NR_CPUS=64 kernel.
> > 
> > Tested on our Thunder system with 48 cores. We could see interrupts to
> > all cores.
> 
> Catalin, Will,
> 
> please consider applying this patch.

This is already in the arm64 for-next/core branch [1].

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=e3672649faae400e8a598938766a63f395a27ae6

> 
> Thanks,
> 
> -Robert
> 
> > 
> > Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> >  arch/arm64/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fd4e81a4e1ce..67fca2ea81a7 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -252,11 +252,11 @@ config SCHED_SMT
> >  	  places. If unsure say N here.
> >  
> >  config NR_CPUS
> > -	int "Maximum number of CPUs (2-32)"
> > -	range 2 32
> > +	int "Maximum number of CPUs (2-64)"
> > +	range 2 64
> >  	depends on SMP
> >  	# These have to remain sorted largest to smallest
> > -	default "8"
> > +	default "64"
> >  
> >  config HOTPLUG_CPU
> >  	bool "Support for hot-pluggable CPUs"
> > -- 
> > 2.0.1
> > 
> 
