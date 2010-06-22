From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 21:29:09 +0900
Subject: [PATCH v2] s3c64xx: Fix build without SDHCI controllers
In-Reply-To: <1276235941-12114-1-git-send-email-m.szyprowski@samsung.com>
References: <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
	<1276235941-12114-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <015c01cb1206$86bfeda0$943fc8e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch fixes the following compilation problem if only NCP machine
> is selected:
> 
> arch/arm/mach-s3c64xx/s3c6410.c: In function ?s3c6410_map_io?:
> arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of function
> ?s3c6410_default_sdhci2?
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied :-)

> ---
>  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 13f9fb2..2e263a8 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -166,8 +166,10 @@ static inline void s3c6410_default_sdhci2(void) { }
>  #else
>  static inline void s3c6410_default_sdhci0(void) { }
>  static inline void s3c6410_default_sdhci1(void) { }
> +static inline void s3c6410_default_sdhci2(void) { }
>  static inline void s3c6400_default_sdhci0(void) { }
>  static inline void s3c6400_default_sdhci1(void) { }
> +static inline void s3c6400_default_sdhci2(void) { }
> 
>  #endif /* CONFIG_S3C64XX_SETUP_SDHCI */
> 
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
