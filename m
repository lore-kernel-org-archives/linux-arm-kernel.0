From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 24 Sep 2015 12:02:31 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sun4i: Enable USB DRC on the
 Marsboard A10
In-Reply-To: <1443080026-4011-1-git-send-email-mamlinav@gmail.com>
References: <1443080026-4011-1-git-send-email-mamlinav@gmail.com>
Message-ID: <5603CA37.8000604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-09-15 09:33, Aleksei Mamlin wrote:
> Enable the otg/drc usb controller on the Marsboard A10.
> Similar to Cubieboard, the 5V of the otg is directly connected to the
> general 5V, so we only use the id pin.
>
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Thanks patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   arch/arm/boot/dts/sun4i-a10-marsboard.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> index 02158bc..9a012db 100644
> --- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> @@ -154,6 +154,10 @@
>   	status = "okay";
>   };
>
> +&otg_sram {
> +	status = "okay";
> +};
> +
>   &pio {
>   	led_pins_marsboard: led_pins at 0 {
>   		allwinner,pins = "PB5", "PB6", "PB7", "PB8";
> @@ -161,6 +165,13 @@
>   		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>   		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>   	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PH4";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
>   };
>
>   &reg_usb1_vbus {
> @@ -184,7 +195,15 @@
>   	status = "okay";
>   };
>
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
>   &usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_detect_pin>;
> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>   	usb1_vbus-supply = <&reg_usb1_vbus>;
>   	usb2_vbus-supply = <&reg_usb2_vbus>;
>   	status = "okay";
>
