From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 26 Nov 2015 18:30:52 +0100
Subject: [PATCH v8 02/17] drm: bridge: analogix/dp: split exynos dp driver
 to bridge directory
In-Reply-To: <1446020519-625-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446020519-625-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1812354.kkj0DGG9mi@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 28. Oktober 2015, 16:21:59 schrieb Yakir Yang:
> Split the dp core driver from exynos directory to bridge directory,
> and rename the core driver to analogix_dp_*, rename the platform
> code to exynos_dp.
> 
> Beside the new analogix_dp driver would export four hooks.
> "analogix_dp_bind()" and "analogix_dp_unbind()"
> "analogix_dp_detect()" and "analogix_dp_get_modes()"
> 
> The bind/unbind symbols is used for analogix platform driver to connect
> with analogix_dp core driver. And the detect/get_modes is used for analogix
> platform driver to init the connector.
> 
> They reason why connector need register in helper driver is rockchip drm
> haven't implement the atomic API, but Exynos drm have implement it, so
> there would need two different connector helper functions, that's why we
> leave the connector register in helper driver.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

[...]

> diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
> index bd1a415..5f74f80 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -55,8 +55,9 @@ config DRM_EXYNOS_DSI
>  	  This enables support for Exynos MIPI-DSI device.
> 
>  config DRM_EXYNOS_DP
> -	bool "EXYNOS DRM DP driver support"
> +	bool "EXYNOS specific extensions for Analogix DP driver"
>  	depends on DRM_EXYNOS && (DRM_EXYNOS_FIMD || DRM_EXYNOS7_DECON)
> +	select DRM_ANALOGIX_DP
>  	default DRM_EXYNOS
>  	select DRM_PANEL
>  	help

This doesn't apply anymore to 4.4-rc due to other changes in there. The 
exynos/Makefile is affected as well.
