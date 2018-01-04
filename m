From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Jan 2018 09:36:53 -0200
Subject: [PATCH V2] ARM: imx_v6_v7_defconfig: select the CONFIG_CPUFREQ_DT
In-Reply-To: <1515091174-30944-1-git-send-email-Anson.Huang@nxp.com>
References: <1515091174-30944-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DnSVKvteBtNB5RqXg3v0kV889w9eDOw=rjx90SiiPx1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 4:39 PM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 29cd1ac..885db90 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -58,6 +58,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>  CONFIG_CPU_FREQ_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPUFREQ_DT=y
>  CONFIG_ARM_IMX6Q_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
> @@ -318,14 +319,6 @@ CONFIG_USB_CONFIGFS_F_MIDI=y
>  CONFIG_USB_CONFIGFS_F_HID=y
>  CONFIG_USB_CONFIGFS_F_UVC=y
>  CONFIG_USB_CONFIGFS_F_PRINTER=y
> -CONFIG_USB_ZERO=m
> -CONFIG_USB_AUDIO=m
> -CONFIG_USB_ETH=m
> -CONFIG_USB_G_NCM=m
> -CONFIG_USB_GADGETFS=m
> -CONFIG_USB_FUNCTIONFS=m
> -CONFIG_USB_MASS_STORAGE=m
> -CONFIG_USB_G_SERIAL=m

Not sure why these are getting removed automatically.

>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
> @@ -350,7 +343,6 @@ CONFIG_RTC_DRV_PCF8563=y
>  CONFIG_RTC_DRV_M41T80=y
>  CONFIG_RTC_DRV_MC13XXX=y
>  CONFIG_RTC_DRV_MXC=y
> -CONFIG_RTC_DRV_MXC_V2=y

This is the rtc driver for mx53.

This driver will land in 4.16, so that's the reason it got removed
automatically by savedefconfig.

It would be safer if your patch could only add a single line:
'CONFIG_CPUFREQ_DT=y'.
