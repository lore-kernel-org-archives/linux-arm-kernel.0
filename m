From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Jun 2017 01:24:32 -0700
Subject: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
In-Reply-To: <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-8-tony@atomide.com>
 <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
Message-ID: <20170608082432.GF3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170607 23:29]:
> On 2017-06-01 01:51, Tony Lindgren wrote:
> > --- a/arch/arm/mach-omap2/dma.c
> > +++ b/arch/arm/mach-omap2/dma.c
> > @@ -334,20 +334,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
> >  	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
> >  	p.errata = configure_dma_errata();
> >  
> > -	if (!of_have_populated_dt()) {
> > -		if (soc_is_omap24xx()) {
> > -			p.slave_map = omap24xx_sdma_map;
> > -			p.slavecnt = ARRAY_SIZE(omap24xx_sdma_map);
> > -		} else if (soc_is_omap34xx() || soc_is_omap3630()) {
> > -			p.slave_map = omap3xxx_sdma_map;
> > -			p.slavecnt = ARRAY_SIZE(omap3xxx_sdma_map);
> > -		} else {
> > -			pr_err("%s: The legacy DMA map is not provided!\n",
> > -			       __func__);
> > -			return -ENODEV;
> > -		}
> > -	}
> > -
> 
> This will conflict with the changes introduced by the tusb6010 DMAengine
> conversion:
> https://patchwork.kernel.org/patch/9734219/

Oops forgot about that one. I'll take a look if it makes sense
to leave the braces for now to avoid a merge conflict.

> with this patch I think the omap24xx_sdma_map and omap3xxx_sdma_map can
> also be removed, but we need to keep the omap24xx_sdma_dt_map for now
> till we have proper DT support for tusb.

OK good point, will check.

Regards,

Tony
