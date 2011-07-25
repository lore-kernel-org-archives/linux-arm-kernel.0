From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 25 Jul 2011 17:01:53 +0530
Subject: [PATCH V4 05/14] ARM: SAMSUNG: Update to use PL330-DMA driver
In-Reply-To: <1311557312-26107-6-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-6-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY07Th8L08gC7NHaft375Kqn1rMsdB6iUo4HKrrPaYQOmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com> wrote:

> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 4d79519..cb170a6 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -300,6 +300,14 @@ config S3C_PL330_DMA
> ? ? ? ?help
> ? ? ? ? ?S3C DMA API Driver for PL330 DMAC.
>
> +config DMADEV_PL330
> + ? ? ? bool
> + ? ? ? select DMADEVICES
> + ? ? ? select PL330_DMA
> + ? ? ? select ARM_AMBA
> + ? ? ? help
> + ? ? ? ? Use DMA device engine for PL330 DMAC.
> +
If this is for the 'wrapper' dma driver, please use S3C or similar prefix.

> diff --git a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
> similarity index 84%
> rename from arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
> rename to arch/arm/plat-samsung/include/plat/dma-pl330.h
> index 8107442..c402719 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
> +++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
> @@ -8,19 +8,18 @@
> ?* (at your option) any later version.
> ?*/
>
> -#ifndef ? ? ? ?__S3C_DMA_PL330_H_
> -#define ? ? ? ?__S3C_DMA_PL330_H_
> -
> -#define S3C2410_DMAF_AUTOSTART ? ? ? ? (1 << 0)
> -#define S3C2410_DMAF_CIRCULAR ? ? ? ? ?(1 << 1)
> +#ifndef __DMA_PL330_H_
> +#define __DMA_PL330_H_ __FILE__
To respect namespaces, please preserve S3C prefix because
the file is Samsung specific.


> @@ -84,6 +83,14 @@ enum dma_ch {
> ? ? ? ?DMACH_SLIMBUS4_TX,
> ? ? ? ?DMACH_SLIMBUS5_RX,
> ? ? ? ?DMACH_SLIMBUS5_TX,
> + ? ? ? DMACH_MTOM_0,
> + ? ? ? DMACH_MTOM_1,
> + ? ? ? DMACH_MTOM_2,
> + ? ? ? DMACH_MTOM_3,
> + ? ? ? DMACH_MTOM_4,
> + ? ? ? DMACH_MTOM_5,
> + ? ? ? DMACH_MTOM_6,
> + ? ? ? DMACH_MTOM_7,
> ? ? ? ?/* END Marker, also used to denote a reserved channel */
> ? ? ? ?DMACH_MAX,
> ?};

Naming mem->mem channels should be unnecessary.
Not sure what you have in mind.
