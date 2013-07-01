From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 01 Jul 2013 16:33:49 +0200
Subject: [PATCH] arm: allow all architectures to change max zone order
In-Reply-To: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
References: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1372689229.4277.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 31.05.2013, 19:02 +0200 schrieb Lucas Stach:
> Many multimedia applications on architectures without an
> IOMMU need large physically contiguous buffers and so need
> to adjust the max zone order of the page allocator.
> 
> There is zero reason to not allow this adjustment on arches
> other than SHMOBILE.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..6ceace8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1710,7 +1710,7 @@ config HW_PERF_EVENTS
>  source "mm/Kconfig"
>  
>  config FORCE_MAX_ZONEORDER
> -	int "Maximum zone order" if ARCH_SHMOBILE
> +	int "Maximum zone order"
>  	range 11 64 if ARCH_SHMOBILE
>  	default "12" if SOC_AM33XX
>  	default "9" if SA1111

Ping. This is really straight forward and low risk.
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
