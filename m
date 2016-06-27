From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 27 Jun 2016 11:30:54 +0200
Subject: [PATCH] drm/mediatek: add ARM_SMCCC dependency
In-Reply-To: <20160627092416.1463857-1-arnd@arndb.de>
References: <20160627092416.1463857-1-arnd@arndb.de>
Message-ID: <8177d497-69bb-db97-5dec-98417dad012a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/27/2016 11:22 AM, Arnd Bergmann wrote:
> ARM SMCCC is only set for ARMv7 and ARMv8 CPUs, but we currently
> allow the driver to be build for older architecture levels as
> well, which results in a link failure:
>
> drivers/gpu/built-in.o: In function `mtk_hdmi_hw_make_reg_writable':
> :(.text+0x1e737c): undefined reference to `arm_smccc_smc'
>
> This adds a Kconfig dependency. The patch applies on my two
> previous fixes that are not yet applied, so please apply all
> three to get randconfig builds to work correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> ---
>  drivers/gpu/drm/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> index 96ebf8bb6024..294de4549922 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -3,6 +3,7 @@ config DRM_MEDIATEK
>  	depends on DRM
>  	depends on ARCH_MEDIATEK || (ARM && COMPILE_TEST)
>  	depends on COMMON_CLK
> +	depends on HAVE_ARM_SMCCC
>  	depends on OF
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>
