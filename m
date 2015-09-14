From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 14 Sep 2015 14:58:21 +0200
Subject: [PATCH v6 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
In-Reply-To: <1442235299-5885-2-git-send-email-info@gerhard-bertelsmann.de>
References: <1442235299-5885-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442235299-5885-2-git-send-email-info@gerhard-bertelsmann.de>
Message-ID: <55F6C46D.7090203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2015 02:54 PM, Gerhard Bertelsmann wrote:
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> ---
> 
>  .../devicetree/bindings/net/can/sun4i_can.txt      |  37 +
>  1 files changed, 37 insertions(+)
> 
> 
> diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> new file mode 100644
> index 0000000..b572e2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> @@ -0,0 +1,37 @@
> +Allwinner A10/A20 CAN controller Device Tree Bindings
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible: "allwinner,sunxican"
> +- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
> +- interrupts: interrupt specifier for the sole interrupt.
> +- clock: phandle and clock specifier.
> +
> +Example
> +-------
> +
> +SoC common .dtsi file:
> +
> +	can0_pins_a: can0 <at> 0 {

That's supposed to be a proper "@":

    can0 at 0

> +		allwinner,pins = "PH20","PH21";
> +		allwinner,function = "can";
> +		allwinner,drive = <0>;
> +		allwinner,pull = <0>;
> +	};
> +
> +	can0: can <at> 01c2bc00 {

    can0 at 01c2bc00

> +		compatible = "allwinner,sunxican";
> +		reg = <0x01c2bc00 0x400>;
> +		interrupts = <0 26 4>;
> +		clocks = <&apb1_gates 4>;
> +		status = "disabled";
> +	};
> +
> +Board specific .dts file:
> +
> +	can0: can <at> 01c2bc00 {

can0 at 01c2bc00

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&can0_pins_a>;
> +		status = "okay";
> +	};
> +
> 

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/faf4ee40/attachment.sig>
