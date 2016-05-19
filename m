From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 May 2016 16:55:53 +0200
Subject: [PATCH 2/5] drm: mediatek: add CONFIG_OF dependency
In-Reply-To: <1463587653-3035181-3-git-send-email-arnd@arndb.de>
References: <1463587653-3035181-1-git-send-email-arnd@arndb.de>
 <1463587653-3035181-3-git-send-email-arnd@arndb.de>
Message-ID: <573DD3F9.5010702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/16 18:07, Arnd Bergmann wrote:
> The mediatek DRM driver can be configured for compile testing with
> CONFIG_OF disabled, but then fails to link:
>
> drivers/gpu/built-in.o: In function `mtk_drm_bind':
> analogix_dp_reg.c:(.text+0x52888): undefined reference to `of_find_device_by_node'
> analogix_dp_reg.c:(.text+0x52930): undefined reference to `of_find_device_by_node'
>
> This adds an explicit Kconfig dependency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> index 545973f6b743..67183e26971d 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -3,6 +3,7 @@ config DRM_MEDIATEK
>   	depends on DRM
>   	depends on ARCH_MEDIATEK || (ARM && COMPILE_TEST)
>   	depends on COMMON_CLK
> +	depends on OF
>   	select DRM_GEM_CMA_HELPER
>   	select DRM_KMS_HELPER
>   	select DRM_MIPI_DSI
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
