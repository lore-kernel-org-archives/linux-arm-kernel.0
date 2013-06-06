From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Jun 2013 22:56:01 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable PWW and backlight options
In-Reply-To: <1370492664-30438-1-git-send-email-festevam@gmail.com>
References: <1370492664-30438-1-git-send-email-festevam@gmail.com>
Message-ID: <20130606145600.GB28270@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 01:24:24AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 

s/PWW/PWM on subject

> These options are useful for controlling backlight contrast via PWM.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index ac3470c..f189887 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -170,7 +170,10 @@ CONFIG_LCD_PLATFORM=y
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_L4F00242T03=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> +CONFIG_LCD_CLASS_DEVICE=y

make ARCH=arm imx_v6_v7_defconfig

arch/arm/configs/imx_v6_v7_defconfig:173:warning: override: reassigning to symbol BACKLIGHT_LCD_SUPPORT
arch/arm/configs/imx_v6_v7_defconfig:174:warning: override: reassigning to symbol LCD_CLASS_DEVICE

Shawn

>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
> +CONFIG_BACKLIGHT_PWM=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>  CONFIG_FONTS=y
> @@ -216,6 +219,8 @@ CONFIG_DRM_IMX_IPUV3_CORE=y
>  CONFIG_DRM_IMX_IPUV3=y
>  CONFIG_COMMON_CLK_DEBUG=y
>  # CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_PWM=y
> +CONFIG_PWM_IMX=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT2_FS_XATTR=y
>  CONFIG_EXT2_FS_POSIX_ACL=y
> -- 
> 1.8.1.2
> 
