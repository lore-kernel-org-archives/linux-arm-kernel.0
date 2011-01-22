From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Sat, 22 Jan 2011 23:24:09 +0530
Subject: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
In-Reply-To: <20110121184020.GD11678@atomide.com>
References: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
	<1295443503-14515-4-git-send-email-s-ghorai@ti.com>
	<20110121184020.GD11678@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB549@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Saturday, January 22, 2011 12:10 AM
> To: Ghorai, Sukumar
> Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [110119 05:24]:
> > add support the irq mode in GPMC.
> > gpmc_init() function move after omap_init_irq() as it has dependecy on
> irq.
> >
[..snip..]

> >
> >  static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> omap2/board-3430sdp.c
> > index 8fb5f43..8304d16 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -335,6 +335,7 @@ static void __init omap_3430sdp_init_irq(void)
> >  	omap2_init_common_infrastructure();
> >  	omap2_init_common_devices(hyb18m512160af6_sdrc_params, NULL);
> >  	omap_init_irq();
> > +	gpmc_init();
> >  }
> ...
> 
> I think I've commented on this before, but why don't you make gpmc_init
> a subsys_initcall? There should be no reason to call this earlier.
> If something does not work because of that, then that issue must be
> fixed.

[Ghorai] You suggested the same in previous v5 and v6; and I mentioned 
the issues [1] that - nand_init()called before subsys_initcall(gpmc_init);
Let me know if I am missing anything again.
 
[1] https://patchwork.kernel.org/patch/212452/
[2] https://patchwork.kernel.org/patch/359152/


> 
> Tony
