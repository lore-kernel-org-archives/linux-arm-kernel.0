From: b-liu@ti.com (Bin Liu)
Date: Tue, 10 Jan 2017 14:24:43 -0600
Subject: [PATCH 4/4] ARM: dts: sun8i: add OTG function to Lichee Pi Zero
In-Reply-To: <20170103152534.20118-5-icenowy@aosc.xyz>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
 <20170103152534.20118-5-icenowy@aosc.xyz>
Message-ID: <20170110202443.GC2479@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 11:25:34PM +0800, Icenowy Zheng wrote:
> Lichee Pi Zero features a USB OTG port.
> 
> Add support for it.
> 
> Note: in order to use the Host mode, the board must be powered via the
> +5V and GND pins.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> index 0099affc6ce3..3d9168cbaeca 100644
> --- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> @@ -71,3 +71,13 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&usb_otg {
> +	dr_mode = "otg";

Why not set this default mode in dtsi instead?

Regards,
-Bin.

> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpio = <&pio 5 6 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> -- 
> 2.11.0
> 
