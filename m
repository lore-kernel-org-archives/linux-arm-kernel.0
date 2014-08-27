From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 27 Aug 2014 03:38:53 +0200
Subject: [PATCH 2/2 v2] ARM: exynos_defconfig: enable USB gadget support
In-Reply-To: <1409038230-7242-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1409038230-7242-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <53FD36AD.1020509@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.08.2014 09:30, schrieb Sjoerd Simons:
> Enable USB gadget support without support for any specific gadgets to
> more easily catch cases where a devices dts doesn't specify the usb
> controllers dr_mode while it should.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  Changes in v2: none
> 
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index fc7d168..3664120 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SMSC911X=y
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_SMSC75XX=y
>  CONFIG_USB_NET_SMSC95XX=y
> +CONFIG_USB_GADGET=y

Do we also need CONFIG_USB_DWC3_DUAL_ROLE=y? The default seemed to be
CONFIG_USB_DWC3_HOST.

>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_CROS_EC=y

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
