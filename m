From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 13:48:19 +0200
Subject: [PATCH] ARM: sun7i: Cubietruck: enable ACIN und USB power supply
 subnode
In-Reply-To: <20170403091245.9766-1-alex@asyring.de>
References: <20170403091245.9766-1-alex@asyring.de>
Message-ID: <20170403114819.sb7pablxrb3qpsar@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 03, 2017 at 11:12:45AM +0200, Alexander Syring wrote:
> The Cubietruck has an AXP209 PMIC and can be power-supplied by ACIN via
>  the CHG-IN pin or by USB.
> 
> This enables the ACIN and the USB power supply subnode in the DT.
> 
> Signed-off-by: Alexander Syring <alex@asyring.de>
> ---
> 
> Send again to all relevant people
> 
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index feb995d29799..98431ef15bc9 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -267,6 +267,10 @@
> 
>  #include "axp209.dtsi"
> 
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
>  &reg_dcdc2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <1000000>;
> @@ -323,6 +327,10 @@
>  	status = "okay";
>  };
> 
> +&usb_power_supply {
> +	status = "okay";
> +};
> +
>  &usbphy {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
> @@ -333,3 +341,4 @@
>  	usb2_vbus-supply = <&reg_usb2_vbus>;
>  	status = "okay";
>  };
> +

You had a whitespace error here. I fixed it, and applied.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/d2682128/attachment.sig>
