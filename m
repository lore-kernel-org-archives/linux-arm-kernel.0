From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 10:40:31 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Guard against multiple inclusion of
 plat/dma.h
In-Reply-To: <1324657414-27991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1324657414-27991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <088701ccc1dd$059b9fc0$10d2df40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Otherwise it'll generate errors if included twice.
> 
Yes, right. Will apply.

Merry Christmas :)
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/include/plat/dma.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-
> samsung/include/plat/dma.h
> index b906112..baa05ed 100644
> --- a/arch/arm/plat-samsung/include/plat/dma.h
> +++ b/arch/arm/plat-samsung/include/plat/dma.h
> @@ -10,6 +10,9 @@
>   * published by the Free Software Foundation.
>  */
> 
> +#ifndef __PLAT_DMA_H
> +#define __PLAT_DMA_H
> +
>  #include <linux/dma-mapping.h>
> 
>  enum s3c2410_dma_buffresult {
> @@ -124,3 +127,5 @@ extern int s3c2410_dma_set_buffdone_fn(enum dma_ch,
> s3c2410_dma_cbfn_t rtn);
> 
> 
>  #include <plat/dma-ops.h>
> +
> +#endif
> --
> 1.7.7.3
