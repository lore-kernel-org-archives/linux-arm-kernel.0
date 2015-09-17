From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 17 Sep 2015 10:04:56 +0200
Subject: [PATCH v8 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
In-Reply-To: <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
Message-ID: <55FA7428.4030801@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2015 01:21 PM, Gerhard Bertelsmann wrote:
> Devicetree bindings for Allwinner A10/A20 CAN
> 
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> ---
> 
>  .../devicetree/bindings/net/can/sun4i_can.txt      |  38 +
>  1 files changed, 389 insertions(+)
> 
> 
> diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> new file mode 100644
> index 0000000..cd0f50c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
> @@ -0,0 +1,38 @@
> +Allwinner A10/A20 CAN controller Device Tree Bindings
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible: "allwinner,sun4i-a10-can"
> +- reg: physical base address and size of the Allwinner A10/A20 CAN register map.
> +- interrupts: interrupt specifier for the sole interrupt.
> +- clock: phandle and clock specifier.
> +
> +
> +Example
> +-------
> +
> +SoC common .dtsi file:
> +
> +	can0_pins_a: can0 at 0 {
> +		allwinner,pins = "PH20","PH21";
> +		allwinner,function = "can";
> +		allwinner,drive = <0>;
> +		allwinner,pull = <0>;
> +	};
> +...
> +	can0: can at 01c2bc00 {
> +		compatible = "allwinner,sun4i-a10-can";
> +		reg = <0x01c2bc00 0x400>;
> +		interrupts = <0 26 4>;
> +		clocks = <&apb1_gates 4>;
> +		status = "disabled";
> +	};

What about adding this snippet to SoC where the CAN core is available?
Maxime, what's the policy on sinxi? If you give me an Ack I'd like to
take the series via linux-can-next (and to net-next) upstream.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/b503fac9/attachment.sig>
