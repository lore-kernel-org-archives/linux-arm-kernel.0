From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Oct 2015 15:25:49 +0200
Subject: [PATCH 5/7] ARM: exynos_defconfig: Normalize exynos defconfig
In-Reply-To: <1445234635-3950-6-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-6-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5624EF5D.7080403@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 10/19/2015 08:03 AM, Alim Akhtar wrote:
> make savedefconfig result in some difference, lets normalize the
> defconfig.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

Did you make savedefconfig against v4.3-rc6 or tot linux-next?

I remember we had issues in the past due savedefconfig made against
linux-next but then some of the patches in linux-next not making it
to the next release. So I think it should be good to mention what's
the base used for this patch.

>  arch/arm/configs/exynos_defconfig |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 1ff2bfa2e183..3349713e6c63 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -99,10 +99,8 @@ CONFIG_SENSORS_LM90=y
>  CONFIG_SENSORS_NTC_THERMISTOR=y
>  CONFIG_SENSORS_PWM_FAN=y
>  CONFIG_SENSORS_INA2XX=y
> -CONFIG_THERMAL=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
> -CONFIG_EXYNOS_THERMAL=y

I would prefer to split all the changes that removes symbols into a
separate patch explaining why these are not needed anymore (i.e: it
is selected now by symbol $foo).

>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MFD_CROS_EC=y
> @@ -127,14 +125,14 @@ CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS65090=y
>  CONFIG_DRM=y
> -CONFIG_DRM_NXP_PTN3460=y
> -CONFIG_DRM_PARADE_PS8622=y
>  CONFIG_DRM_EXYNOS=y
>  CONFIG_DRM_EXYNOS_FIMD=y
>  CONFIG_DRM_EXYNOS_DSI=y
>  CONFIG_DRM_EXYNOS_HDMI=y
>  CONFIG_DRM_PANEL_SIMPLE=y
>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> +CONFIG_DRM_NXP_PTN3460=y
> +CONFIG_DRM_PARADE_PS8622=y

Moving these DRM bridge symbols to match savedefconfig is ok IMHO.

>  CONFIG_FB_SIMPLE=y
>  CONFIG_EXYNOS_VIDEO=y
>  CONFIG_EXYNOS_MIPI_DSI=y
> @@ -175,7 +173,6 @@ CONFIG_RTC_DRV_S5M=y
>  CONFIG_RTC_DRV_S3C=y
>  CONFIG_DMADEVICES=y
>  CONFIG_PL330_DMA=y
> -CONFIG_CHROME_PLATFORMS=y
>  CONFIG_CROS_EC_CHARDEV=y
>  CONFIG_COMMON_CLK_MAX77686=y
>  CONFIG_COMMON_CLK_MAX77802=y
> @@ -190,7 +187,6 @@ CONFIG_PWM_SAMSUNG=y
>  CONFIG_PHY_EXYNOS5250_SATA=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> -CONFIG_EXT4_FS=y
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
> 

Same comment than above, I would prefer these to be split.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
