From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 09:45:09 +0900
Subject: [PATCH 3/6] S5PV210: OneNAND: Define OneNAND IRQ if defined
In-Reply-To: <20100728101201.GA21341@july>
References: <20100728101201.GA21341@july>
Message-ID: <007201cb2eb7$56455bb0$02d01310$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Define OneNAND interrupt if defined
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-onenand.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/dev-onenand.c
b/arch/arm/plat-s5p/dev-onenand.c
> index 4d3eddb..612d166 100644
> --- a/arch/arm/plat-s5p/dev-onenand.c
> +++ b/arch/arm/plat-s5p/dev-onenand.c
> @@ -33,6 +33,13 @@ static struct resource s5pc110_onenand_resources[] = {
>  		.end	= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
> +#ifdef IRQ_ONENAND_AUDI

Hmm...need to check mach/irqs.h so that we can remove #ifdef like above.
Actually, we can remove it.

> +	[2] = {
> +		.start	= IRQ_ONENAND_AUDI,
> +		.end	= IRQ_ONENAND_AUDI,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +#endif
>  };
> 
>  struct platform_device s5pc110_device_onenand = {
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
