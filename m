From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:55:25 +0100
Subject: [PATCH v2 1/8] dt-bindings: add binding for the Allwinner DE2 CCU
In-Reply-To: <20170316204748.8596-2-icenowy@aosc.xyz>
References: <20170316204748.8596-1-icenowy@aosc.xyz>
 <20170316204748.8596-2-icenowy@aosc.xyz>
Message-ID: <20170320095525.osvx5zba4xkfqm25@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 04:47:41AM +0800, Icenowy Zheng wrote:
> Allwinner "Display Engine 2.0" contains some clock controls in it.
> 
> Add them as a clock driver, and make a device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  .../devicetree/bindings/clock/sun8i-de2.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> new file mode 100644
> index 000000000000..c19496f037a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> @@ -0,0 +1,31 @@
> +Allwinner Display Engine 2.0 Clock Control Binding
> +--------------------------------------------------
> +
> +Required properties :
> +- compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a83t-de2-clk"
> +		- "allwinner,sun50i-a64-de2-clk"
> +		- "allwinner,sun50i-h5-de2-clk"
> +
> +- reg: Must contain the registers base address and length
> +- clocks: phandle to the clocks feeding the display engine subsystem.
> +	  Three are needed:
> +  - "mod": the display engine module clock
> +  - "bus": the bus clock for the whole display engine subsystem
> +- clock-names: Must contain the clock names described just above
> +- resets: phandle to the reset control for the display engine subsystem.
> +- #clock-cells : must contain 1
> +- #reset-cells : must contain 1
> +
> +Example:
> +de2_clocks: clock at 01000000 {
> +	compatible = "allwinner,sun50i-a64-de2-clk";
> +	reg = <0x01000000 0x1c>;

Please use the full size of the memory area allocated to that device.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/f2d8df95/attachment.sig>
