From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 09:36:52 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable WiFi-Ex as a module instead
 built-in
In-Reply-To: <1443530546-3066-1-git-send-email-javier@osg.samsung.com>
References: <1443530546-3066-1-git-send-email-javier@osg.samsung.com>
Message-ID: <560B2EA4.8050406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.09.2015 21:42, Javier Martinez Canillas wrote:
> The Marvell WiFi-Ex driver tries to load a firmware on probe. So if the
> driver is built-in and probed before a firmware is available, this is
> not loaded and the chip does not work.
> 
> This happens for example if an initramfs isn't used since the driver is
> probed before the root filesystem is mounted.
> 
> Change the default config since the driver isn't needed for machines to
> boot and is more convenient to have it enabled as a module to avoid
> requiring an initramfs or to have the firmware built into the kernel.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/exynos_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The user-space can always initiate re-probing of device - just re-bind
it. However I assume that driver cannot work without firmware?

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index d4f6063d8a72..5aad617f02c7 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -64,8 +64,8 @@ CONFIG_SMSC911X=y
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_SMSC75XX=y
>  CONFIG_USB_NET_SMSC95XX=y
> -CONFIG_MWIFIEX=y
> -CONFIG_MWIFIEX_SDIO=y
> +CONFIG_MWIFIEX=m
> +CONFIG_MWIFIEX_SDIO=m
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_CROS_EC=y
> 
