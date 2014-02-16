From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 17 Feb 2014 00:31:32 +0100
Subject: [PATCH] arm: msm: remove MACH_MSM7X30_SURF
In-Reply-To: <20140216231407.GA18892@fifo99.com>
References: <1392572080.28866.19.camel@x220>
 <20140216231407.GA18892@fifo99.com>
Message-ID: <1392593492.28648.11.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Sun, 2014-02-16 at 23:14 +0000, dwalker at fifo99.com wrote:
> On Sun, Feb 16, 2014 at 06:34:40PM +0100, Paul Bolle wrote:
> > The Kconfig symbol MACH_MSM7X30_SURF was added in v2.6.35. It has never
> > been used. Setting it has no effect. There are no calls for
> > machine_is_mach_msm7x30(). This symbol can safely be removed.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Tested only with "git grep".
> > 
> >  arch/arm/mach-msm/Kconfig | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> > index 9625cf3..dab941a 100644
> > --- a/arch/arm/mach-msm/Kconfig
> > +++ b/arch/arm/mach-msm/Kconfig
> > @@ -62,7 +62,6 @@ config ARCH_MSM7X30
> >  	select ARCH_MSM_SCORPION
> >  	select CPU_V7
> >  	select GPIO_MSM_V1
> > -	select MACH_MSM7X30_SURF # if !
> >  	select MSM_GPIOMUX
> >  	select MSM_PROC_COMM
> >  	select MSM_SMD
> > @@ -115,12 +114,6 @@ config MACH_TROUT
> >  	help
> >  	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
> >  
> > -config MACH_MSM7X30_SURF
> > -	depends on ARCH_MSM7X30
> > -	bool "MSM7x30 SURF"
> > -	help
> > -	  Support for the Qualcomm MSM7x30 SURF eval board.
> > -
> 
> 
> It's not really enough .. There are support files for this platform, if you remove it you need to remove
> those files also. You could also go the other way and connect the config option to those files.

What support files are you thinking about here?

(Note that I need to rethink this patch anyway. The discussion about the
patch that removes MACH_MXLADS showed me that machine_is_mach_msm7x30()
is used in a more subtle way than I remembered. I hope to revisit this
and similar patches in a few days to review them myself.)

Thanks,


Paul Bolle
