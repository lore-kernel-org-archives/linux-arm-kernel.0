From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 24 Dec 2014 10:45:17 +0100
Subject: [PATCH] ARM: socfpga: dts: Add adxl34x
In-Reply-To: <1419339862-29852-1-git-send-email-walter@vanguardiasur.com.ar>
References: <1419339862-29852-1-git-send-email-walter@vanguardiasur.com.ar>
Message-ID: <20141224094516.GI13070@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Dec 23, 2014 at 10:04:22AM -0300, Walter Lozano wrote:
> This patch adds the DTS bindings for the adxl34x digital
> accelerometer.
> 

Thanks for doing this. Does the ADXL34 work now? Last time I
tried it, I didn't get any interrupts, but as I didn't really
care for the accelerometer I didn't dig deeper.

> Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index 16ea6f5..f99d7dec 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -68,3 +68,20 @@
>  &usb1 {
>  	status = "okay";
>  };
> +
> +&gpio2 {
> +	status = "okay";
> +};
> +
> +&i2c1{
       ^^^

Add a space here and ...

> +	status = "okay";
> +
> +	accel1: accel1 at 53{
			^^^
here. Also, this should be accelerometer at 53.

> +		compatible = "adxl34x";
> +		reg = <0x53>;
> +
> +		interrupt-parent = < &portc >;
				   ^^^    ^^^
Please remove the spaces here.
> +		interrupts = <3 2>;
> +
> +	};
> +};

Finally, please sort the nodes alphabetically and not just append them.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
