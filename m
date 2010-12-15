From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 14 Dec 2010 16:55:49 -0800
Subject: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
In-Reply-To: <87d3p3q35h.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 14 Dec 2010 16:40:42 -0800")
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-8-git-send-email-manjugk@ti.com>
	<87d3p3q35h.fsf@deeprootsystems.com>
Message-ID: <87aak7onvu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

>
> Using the patch below which fixes up the interrupt numbers to match the
> original code, the memory-to-memory test is now working on OSK.

Tony, if you prefer just to fold this into the original, feel free to
add

[khilman at deeprootsystems.com]: fixed IRQ numbers to match original code
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>


> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 17814e0..d855934 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -121,58 +121,58 @@ static struct resource res[] __initdata = {
>  	/* Handled in lcd_dma.c */
>  	[7] = {
>  		.name   = "6",
> -		.start  = INT_DMA_LCD,
> +		.start  = INT_1610_DMA_CH6,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	/* irq's for omap16xx and omap7xx */
>  	[8] = {
>  		.name   = "7",
> -		.start  = 53 + IH2_BASE,
> +		.start  = INT_1610_DMA_CH7,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	[9] = {
>  		.name   = "8",
> -		.start  = 54 + IH2_BASE,
> +		.start  = INT_1610_DMA_CH8,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	[10] = {
>  		.name  = "9",
> -		.start = 55 + IH2_BASE,
> +		.start = INT_1610_DMA_CH9,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[11] = {
>  		.name  = "10",
> -		.start = 56 + IH2_BASE,
> +		.start = INT_1610_DMA_CH10,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[12] = {
>  		.name  = "11",
> -		.start = 57 + IH2_BASE,
> +		.start = INT_1610_DMA_CH11,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[13] = {
>  		.name  = "12",
> -		.start = 58 + IH2_BASE,
> +		.start = INT_1610_DMA_CH12,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[14] = {
>  		.name  = "13",
> -		.start = 59 + IH2_BASE,
> +		.start = INT_1610_DMA_CH13,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[15] = {
>  		.name  = "14",
> -		.start = 60 + IH2_BASE,
> +		.start = INT_1610_DMA_CH14,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[16] = {
>  		.name  = "15",
> -		.start = 61 + IH2_BASE,
> +		.start = INT_1610_DMA_CH15,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[17] = {
>  		.name  = "16",
> -		.start = 62 + IH2_BASE,
> +		.start = INT_DMA_LCD,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  };
