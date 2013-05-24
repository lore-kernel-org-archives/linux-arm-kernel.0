From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 23 May 2013 19:21:17 -0700 (PDT)
Subject: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
In-Reply-To: <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
References: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
 <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <877gip2k4l.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > +static __init void r8a7790_register_sata1(void)
> > +{
> > +
> > +	struct resource res[] = {
> > +		DEFINE_RES_MEM_NAMED(0xee300000, 0x200000, "rcar-sata"),
> > +		DEFINE_RES_IRQ(gic_iid(106)),
> > +	};
> > +
> > +	struct platform_device_info pdevinfo = {
> > +		.name = "sata_rcar",
> > +		.id = 1,
> > +		.res = res,
> > +		.num_res = ARRAY_SIZE(res),
> > +		.dma_mask = DMA_BIT_MASK(32),
> > +	};
> > +
> > +	platform_device_register_full(&pdevinfo);
> > +}

This "using local variable" make sense.
It don't need "__initdata"


Best regards
---
Kuninori Morimoto
