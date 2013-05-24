From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 23 May 2013 19:17:22 -0700 (PDT)
Subject: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
In-Reply-To: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
References: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Add SATA clock for r8a7790 SoC (for both device tree and usual cases).
> Register SATA controller as a "late" platform device on r8a7790 SoC.
> 
> Based on "ARM: mach-shmobile: r8a7779: add SATA support" by
> Vladimir Barinov.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

> +	CLKDEV_DEV_ID("sata_rcar.1", &mstp_clks[MSTP814]),
(snip)
> +static __init void r8a7790_register_sata1(void)
> +{
> +
> +	struct resource res[] = {
> +		DEFINE_RES_MEM_NAMED(0xee300000, 0x200000, "rcar-sata"),
> +		DEFINE_RES_IRQ(gic_iid(106)),
> +	};
> +
> +	struct platform_device_info pdevinfo = {
> +		.name = "sata_rcar",
> +		.id = 1,
> +		.res = res,
> +		.num_res = ARRAY_SIZE(res),
> +		.dma_mask = DMA_BIT_MASK(32),
> +	};
> +
> +	platform_device_register_full(&pdevinfo);
> +}

This is a little bit strange for me.
Why you don't care SATA0 ?

Can you use like this ?

static __init void r8a7790_register_sata(int id);


BTW, we need to decide "driver registration function naming" ?
In r8a7778 case, it is using 

	r8a7778_add_xxx_device()
	r8a7778_add_xxx_devices()

but r8a7778_register_xxx seems nice naming :)

Best regards
---
Kuninori Morimoto
