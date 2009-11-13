From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 13 Nov 2009 23:38:19 +0000
Subject: [PATCH 18/18] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform
In-Reply-To: <1258014122-18185-19-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-10-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-11-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-12-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-13-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-14-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-15-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-16-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-17-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-18-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-19-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091113233819.GV4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:22:02AM +0100, Marek Szyprowski wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Samsung S5PC100 SoC has SDHCI controller compatible to the one known from
> S3C64xx SoCs. Enable support for sdhci-s3c driver also on S5PC1xx platform.

This can go to the SDHCI mainter(s) with my Acked-by line.

Begining to think we need a CONFIG_HAS_SAMSUNG_SDHCI somewhere that these
archs can select.
 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 432ae83..faddf82 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -96,7 +96,7 @@ config MMC_SDHCI_PLTFM
>  
>  config MMC_SDHCI_S3C
>  	tristate "SDHCI support on Samsung S3C SoC"
> -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> +	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX || PLAT_S5PC1XX)
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  often referrered to as the HSMMC block in some of the Samsung S3C
> -- 
> 1.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
