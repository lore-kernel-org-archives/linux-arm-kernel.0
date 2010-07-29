From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 09:34:04 +0900
Subject: [PATCH 2/6] S5PC210: OneNAND: Use the correct DMA address range
In-Reply-To: <20100728101146.GA21333@july>
References: <20100728101146.GA21333@july>
Message-ID: <007001cb2eb5$c26ef140$474cd3c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> OneNAND DMA SFR requires the 8KiB mapping.
> 
It would be helpful if you could add the reason why should change.

Just fix the DMA address range? Or for support further SoCs?...

> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-onenand.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/dev-onenand.c
b/arch/arm/plat-s5p/dev-onenand.c
> index 08b3a3f..4d3eddb 100644
> --- a/arch/arm/plat-s5p/dev-onenand.c
> +++ b/arch/arm/plat-s5p/dev-onenand.c
> @@ -30,7 +30,7 @@ static struct resource s5pc110_onenand_resources[] = {
>  	},
>  	[1] = {
>  		.start	= S5PC110_PA_ONENAND_DMA,
> -		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
> +		.end	= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  };
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
