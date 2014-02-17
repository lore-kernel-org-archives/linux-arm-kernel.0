From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Feb 2014 12:30:19 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Enable SDHI, GPIO and regulators
 in defconfig
In-Reply-To: <1392273587-12196-1-git-send-email-horms+renesas@verge.net.au>
References: <1392273587-12196-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140217033019.GA19146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 03:39:47PM +0900, Simon Horman wrote:
> Enable the following:
> * regulators (needed for SDHI)
> * SDHI
> * GPIO
> * GPIO keys
> * GPIO LEDs
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.

> ---
>  arch/arm/configs/koelsch_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index 9561139..86faab5 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -59,6 +59,7 @@ CONFIG_SH_ETH=y
>  # CONFIG_NET_VENDOR_VIA is not set
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> +CONFIG_KEYBOARD_GPIO=y
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_SH_SCI=y
> @@ -68,13 +69,21 @@ CONFIG_I2C=y
>  CONFIG_I2C_RCAR=y
>  CONFIG_SPI=y
>  CONFIG_SPI_RSPI=y
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_RCAR=y
>  # CONFIG_HWMON is not set
>  CONFIG_THERMAL=y
>  CONFIG_RCAR_THERMAL=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_GPIO=y
>  # CONFIG_HID is not set
>  # CONFIG_USB_SUPPORT is not set
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHI=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=y
> -- 
> 1.8.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
