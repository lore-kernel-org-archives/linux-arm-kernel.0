From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 23 Jun 2017 23:13:21 +0530
Subject: [PATCH 1/4] ARM: exynos_defconfig: Enable Bluetooth, mac80211,
 NFC and more USB drivers
In-Reply-To: <20170621191659.10929-1-krzk@kernel.org>
References: <20170621191659.10929-1-krzk@kernel.org>
Message-ID: <CANAwSgTHZq+betbSH_UgMs4iBViecCdb7e_yB6xjsZQXn0wCYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 22 June 2017 at 00:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Enable useful, but not essential, stacks and drivers as modules:
>  - Bluetooth,
>  - mac80211,
>  - NFC,
>  - some USB network adapters,
>  - USB storage,
>  - additional USB devices (printers etc).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/configs/exynos_defconfig | 57 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 25325ed9319e..e6a976f5305c 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -48,7 +48,43 @@ CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
> +CONFIG_BT=m
> +CONFIG_BT_RFCOMM=m
> +CONFIG_BT_RFCOMM_TTY=y
> +CONFIG_BT_BNEP=m
> +CONFIG_BT_BNEP_MC_FILTER=y
> +CONFIG_BT_BNEP_PROTO_FILTER=y
> +CONFIG_BT_HIDP=m
> +CONFIG_BT_LEDS=y
> +CONFIG_BT_HCIBTUSB=m
> +CONFIG_BT_HCIBTSDIO=m
> +CONFIG_BT_HCIUART=m
> +CONFIG_BT_HCIUART_BCSP=y
> +CONFIG_BT_HCIUART_ATH3K=y
> +CONFIG_BT_HCIUART_3WIRE=y
> +CONFIG_BT_HCIUART_INTEL=y
> +CONFIG_BT_HCIUART_BCM=y
> +CONFIG_BT_HCIUART_QCA=y
> +CONFIG_BT_HCIUART_AG6XX=y
> +CONFIG_BT_HCIUART_MRVL=y
> +CONFIG_BT_HCIBCM203X=m
> +CONFIG_BT_HCIBPA10X=m
> +CONFIG_BT_HCIBFUSB=m
> +CONFIG_BT_HCIVHCI=m
> +CONFIG_BT_MRVL=m
> +CONFIG_BT_MRVL_SDIO=m
> +CONFIG_BT_ATH3K=m
>  CONFIG_CFG80211=y
> +CONFIG_MAC80211=y
> +CONFIG_MAC80211_LEDS=y
> +CONFIG_NFC=y
> +CONFIG_NFC_DIGITAL=m
> +CONFIG_NFC_NCI=y
> +CONFIG_NFC_NCI_SPI=m
> +CONFIG_NFC_NCI_UART=m
> +CONFIG_NFC_HCI=m
> +CONFIG_NFC_SHDLC=y
> +CONFIG_NFC_S3FWRN5_I2C=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_DMA_CMA=y
> @@ -65,7 +101,9 @@ CONFIG_BLK_DEV_DM=y
>  CONFIG_DM_CRYPT=m
>  CONFIG_NETDEVICES=y
>  CONFIG_SMSC911X=y
> +CONFIG_USB_RTL8150=m
>  CONFIG_USB_RTL8152=y
> +CONFIG_USB_LAN78XX=m
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_SMSC75XX=y
>  CONFIG_USB_NET_SMSC95XX=y
> @@ -189,7 +227,25 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_EXYNOS=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_EXYNOS=y
> +CONFIG_USB_ACM=m
> +CONFIG_USB_PRINTER=m
> +CONFIG_USB_WDM=m
> +CONFIG_USB_TMC=m
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_STORAGE_REALTEK=m
> +CONFIG_USB_STORAGE_DATAFAB=m
> +CONFIG_USB_STORAGE_FREECOM=m
> +CONFIG_USB_STORAGE_ISD200=m
> +CONFIG_USB_STORAGE_USBAT=m
> +CONFIG_USB_STORAGE_SDDR09=m
> +CONFIG_USB_STORAGE_SDDR55=m
> +CONFIG_USB_STORAGE_JUMPSHOT=m
> +CONFIG_USB_STORAGE_ALAUDA=m
> +CONFIG_USB_STORAGE_ONETOUCH=m
> +CONFIG_USB_STORAGE_KARMA=m
> +CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> +CONFIG_USB_STORAGE_ENE_UB6250=m
> +CONFIG_USB_UAS=m
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_HSIC_USB3503=y
> @@ -209,7 +265,6 @@ CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_PWM=y
>  CONFIG_LEDS_MAX77693=y
>  CONFIG_LEDS_MAX8997=y
> -CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_MAX8997=y

For whole series.

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand Moon
