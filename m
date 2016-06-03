From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Jun 2016 09:36:03 +0200
Subject: [PATCH v2 5/9] arm64: Add BCM2835 support to the defconfig.
In-Reply-To: <1464934708-24769-6-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-6-git-send-email-kraxel@redhat.com>
Message-ID: <3299125.qWct7BqQgQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 3, 2016 8:18:24 AM CEST Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> Made with make defconfig; make menuconfig (only saying Y to new
> entries); make savedefconfig.

Please try not to mix 'make savedefconfig' changes with your
own changes, it make it harder to review and can lead to more
conflicts.

> @@ -140,6 +141,9 @@ CONFIG_USB_NET_PLUSB=m
>  CONFIG_USB_NET_MCS7830=m
>  CONFIG_WL18XX=m
>  CONFIG_WLCORE_SDIO=m
> +CONFIG_USB_USBNET=y
> +CONFIG_USB_NET_SMSC95XX=y
> +# CONFIG_WLAN is not set
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y

Can this be =m like the others?

> -CONFIG_FB=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y

Is this intended?

> +CONFIG_DRM=y
> +CONFIG_DRM_VC4=y
>  CONFIG_FB_ARMCLCD=y
>  CONFIG_LOGO=y

Maybe modules?


>  # CONFIG_LOGO_LINUX_MONO is not set
>  # CONFIG_LOGO_LINUX_VGA16 is not set
>  CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
> +CONFIG_SND_BCM2835_SOC_I2S=y
>  CONFIG_SND_SOC_RCAR=y
>  CONFIG_SND_SOC_AK4613=y
>  CONFIG_USB=y

We probably want CONFIG_SND=m, but that should be a separate patch.

> @@ -270,6 +284,7 @@ CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_RTC_DRV_XGENE=y
>  CONFIG_DMADEVICES=y
>  CONFIG_PL330_DMA=y
> +CONFIG_DMA_BCM2835=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_QCOM_BAM_DMA=y
>  CONFIG_RCAR_DMAC=y

Does any essential driver depend on this one?

> @@ -311,7 +329,6 @@ CONFIG_AUTOFS4_FS=y
>  CONFIG_FUSE_FS=y
>  CONFIG_CUSE=y
>  CONFIG_VFAT_FS=y
> -CONFIG_TMPFS=y
>  CONFIG_HUGETLBFS=y
>  CONFIG_CONFIGFS_FS=y
>  CONFIG_EFIVAR_FS=y

Why?

	Arnd
