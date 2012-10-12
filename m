From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 12 Oct 2012 09:06:51 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007015405.958959522@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
Message-ID: <20121012070651.GA17511@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Sun, Oct 07, 2012 at 03:53:01AM +0200, Domenico Andreoli wrote:
>
> Index: b/arch/arm/mach-bcm476x/bcm476x.c
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/mach-bcm476x/bcm476x.c
...
> +
> +#define BCM476X_PERIPH_PHYS   0x00080000
> +#define BCM476X_PERIPH_VIRT   0xd0080000

Are you sure I should use IOMEM() here? The only place I use these macros
is here below, for which I should add a cast to silent the compiler. All
the other accesses go throught ioremap/readl/writel, if not I want to fix it.

> +
> +static struct map_desc io_map __initdata = {
> +	.virtual = BCM476X_PERIPH_VIRT,
> +	.pfn = __phys_to_pfn(BCM476X_PERIPH_PHYS),
> +	.length = BCM476X_PERIPH_SIZE,
> +	.type = MT_DEVICE,
> +};

Regards,
Domenico
