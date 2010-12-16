From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Dec 2010 10:27:55 -0800
Subject: [PATCH] OMAP: RM-680: fix omap2_init_common_hw compile break
In-Reply-To: <20101216180514.GA31322@n2100.arm.linux.org.uk>
References: <1292520438-29122-1-git-send-email-omar.ramirez@ti.com>
	<20101216180514.GA31322@n2100.arm.linux.org.uk>
Message-ID: <20101216182755.GI5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101216 10:05]:
> On Thu, Dec 16, 2010 at 11:27:18AM -0600, Omar Ramirez Luna wrote:
> > diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> > index 8ba4047..781ed25 100644
> > --- a/arch/arm/mach-omap2/board-am3517crane.c
> > +++ b/arch/arm/mach-omap2/board-am3517crane.c
> > @@ -47,7 +47,8 @@ static void __init am3517_crane_init_irq(void)
> >  	omap_board_config = am3517_crane_config;
> >  	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
> >  
> > -	omap2_init_common_hw(NULL, NULL);
> > +	omap2_init_common_infrastructure();
> > +	omap2_init_common_devices(NULL, NULL);
> >  	omap_init_irq();
> 
> Once I have the init_early() sorted, hopefully most of the abuse in
> these callbacks can be moved into the init_early() callback.

Sounds good to me.

Thanks,

Tony
