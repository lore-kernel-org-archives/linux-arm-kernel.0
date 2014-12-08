From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Dec 2014 23:15:09 +0100
Subject: [PATCHv2 1/3] sunxi:dts-bindings:input:ps2 bindings for A10/A20
 ps2.
In-Reply-To: <1417907719-26775-2-git-send-email-VishnuPatekar0510@gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
 <1417907719-26775-2-git-send-email-VishnuPatekar0510@gmail.com>
Message-ID: <20141208221509.GM8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 07, 2014 at 04:45:17AM +0530, vishnupatekar wrote:
> A10 and A20 have same PS2 addresses, clocks, interrupts.
> added compatible as allwinner,sun4i-a10-ps2.
> 
> Signed-off-by: vishnupatekar <VishnuPatekar0510@gmail.com>

You should have your real name here.

> ---
>  .../bindings/input/allwinner,sunxi-ps2.txt         |   23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt b/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt
> new file mode 100644
> index 0000000..3a8919a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt
> @@ -0,0 +1,23 @@
> +* Device tree bindings for Allwinner A10, A20 PS2 host controller

> +A20 PS2 is dual role controller(PS2 host and PS2 device). These
> +bindings are for PS2 host controller. IBM compliant IBM PS2 and
> AT-compatible keyboard and mouse can be connected.

This should be wrapped to 80 chars.

> +Required properties:
> +
> + - reg             : Offset and length of the register set for the device.
> + - compatible      : Should one of the following:
> +                     - "allwinner,sun7i-a20-ps2"
> +                     - "allwinner,sun4i-a10-ps2"
> + - interrupts      : The interrupt line connected to the PS2.
> + - clocks          : The gate clk connected to the PS2.
> +
> +
> +Example:
> +	ps20: ps2 at 0x01c2a000 {
> +		compatible = "allwinner,sun7i-a20-ps2";
> +		reg = <0x01c2a000 0x400>;
> +		interrupts = <0 62 4>;
> +		clocks = <&apb1_gates 6>;
> +		status = "disabled";
> +	};
> -- 
> 1.7.9.5
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/3b63a824/attachment.sig>
