From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 14:45:23 -0700
Subject: [PATCH V4] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
In-Reply-To: <524D44B9.30208@ti.com>
References: <1379520162-31932-1-git-send-email-r.sricharan@ti.com>
 <524D44B9.30208@ti.com>
Message-ID: <20131008214523.GU8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [131003 03:27]:
> On Wednesday 18 September 2013 09:32 PM, Sricharan R wrote:
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -52,7 +52,6 @@
> >  			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
> > -		clock-frequency = <6144000>;
> >  	};
> >  
> >  	gic: interrupt-controller at 48211000 {

Can the above be done later on in a separate clean-up patch?
If so I can drop that part as that removes a dependency to the
.dts patches queued by Benoit.

> > --- a/arch/arm/mach-omap2/omap-smp.c
> > +++ b/arch/arm/mach-omap2/omap-smp.c
> > @@ -41,6 +41,8 @@
> >  
> >  u16 pm44xx_errata;
> >  
> > +extern unsigned long arch_timer_freq;
> > +
> >  /* SCU base address */
> >  static void __iomem *scu_base;
> >  

No externs in *.c files please, checkpatch.pl and sparse should warn
about this.

>  Are you planning to pull this patch and the below $subject patch as well? They are
>  acked and tested.
> 
>  ARM: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency
> 
>   http://www.spinics.net/lists/linux-omap/msg97281.html

The 20MHz patch I've applied, just noticed the above things
when was about to apply this.

Regards,

Tony
