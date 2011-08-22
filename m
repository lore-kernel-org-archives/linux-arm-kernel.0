From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 14:20:02 +0200
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <002b01cc60c2$b83eff40$28bcfdc0$%kim@samsung.com>
References: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
	<000601cc5e30$3a38bda0$aeaa38e0$%kim@samsung.com>
	<001c01cc6082$123cef20$36b6cd60$%kim@samsung.com>
	<001d01cc6085$cd836900$688a3b00$%kim@samsung.com>
	<CACRpkdat3-CRbMBsis=fTGcu61zhVvfXMqG_S_CRjBwCo2vTsQ@mail.gmail.com>
	<002b01cc60c2$b83eff40$28bcfdc0$%kim@samsung.com>
Message-ID: <CACRpkdZqFQC+YOwHe8=SDvh3uKM5YgJhQZ8kgtY08qoEx5OumQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/22 Boojin Kim <boojin.kim@samsung.com>:

> I used 'exynos4_defconfig'. And then enables 'Device Drivers-> DMA Engine
> support -> DMA API Driver for PL330' option and modify code as below.
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 2e3b3d3..763e846 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -193,6 +193,7 @@ config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
> ?config PL330_DMA
> ? ? ? ?tristate "DMA API Driver for PL330"
> ? ? ? ?select DMA_ENGINE
> + ? ? ? select ARM_AMBA
> ? ? ? ?depends on PL330
> ? ? ? ?help
> ? ? ? ? ?Select if your platform has one or more PL330 DMACs.
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 00eee59..fcad90c 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -17,6 +17,7 @@
> ?#include <linux/interrupt.h>
> ?#include <linux/amba/bus.h>
> ?#include <linux/amba/pl330.h>
> +#include <linux/scatterlist.h>
>
> ?#define NR_DEFAULT_DESC ? ? ? ?16

Thanks!

This looks like a separate patch to activate the DMA driver,
this should probably go into -rc.

Linus Walleij
