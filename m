From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 16 Jan 2012 21:51:59 +0100
Subject: [PATCH v2] ARM: mx28: Let audio support be built by default
In-Reply-To: <1326739891-21529-1-git-send-email-fabio.estevam@freescale.com>
References: <1325169961-11923-1-git-send-email-festevam@gmail.com>
 <1326739891-21529-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <201201162151.59421.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Let audio support be built by default.
> 
> As sgtl5000 codec is connected via I2C, let MXS I2C driver also be built
> by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Add regulator config options
> 
>  arch/arm/configs/mxs_defconfig |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/mxs_defconfig
> b/arch/arm/configs/mxs_defconfig index 6ee781b..1ebbf45 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -77,10 +77,10 @@ CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
> -CONFIG_I2C=m
> +CONFIG_I2C=y
>  # CONFIG_I2C_COMPAT is not set
> -CONFIG_I2C_CHARDEV=m
> -CONFIG_I2C_MXS=m
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MXS=y
>  CONFIG_SPI=y
>  CONFIG_SPI_GPIO=m
>  CONFIG_DEBUG_GPIO=y
> @@ -90,6 +90,20 @@ CONFIG_GPIO_SYSFS=y
>  CONFIG_DISPLAY_SUPPORT=m
>  # CONFIG_HID_SUPPORT is not set
>  # CONFIG_USB_SUPPORT is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_TIMER=y
> +CONFIG_SND_PCM=y
> +CONFIG_SND_JACK=y
> +CONFIG_SND_DRIVERS=y
> +CONFIG_SND_ARM=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_MXS_SOC=y
> +CONFIG_SND_SOC_MXS_SGTL5000=y
> +CONFIG_SND_SOC_I2C_AND_SPI=y
> +CONFIG_SND_SOC_SGTL5000=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_MXS=y
>  CONFIG_RTC_CLASS=y

Acked-by: Marek Vasut <marek.vasut@gmail.com>
