From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 3 May 2014 10:45:20 -0700
Subject: [PATCH v5 1/3] ARM: sunxi: Add documentation for sunxi consumer
 infrared devices
In-Reply-To: <1398871010-30681-2-git-send-email-bay@hackerdom.ru>
References: <1398871010-30681-1-git-send-email-bay@hackerdom.ru>
 <1398871010-30681-2-git-send-email-bay@hackerdom.ru>
Message-ID: <20140503174520.GA15342@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 09:16:48PM +0600, Alexander Bersenev wrote:
> This patch adds documentation for Device-Tree bindings for sunxi IR
> controller.
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  .../devicetree/bindings/media/sunxi-ir.txt         | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sunxi-ir.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> new file mode 100644
> index 0000000..d502cf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -0,0 +1,23 @@
> +Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
> +
> +Required properties:
> +- compatible	    : should be "allwinner,sun7i-a20-ir";
> +- clocks	    : list of clock specifiers, corresponding to
> +		      entries in clock-names property;
> +- clock-names	    : should contain "apb0_ir0" and "ir0" entries;
> +- interrupts	    : should contain IR IRQ number;
> +- reg		    : should contain IO map address for IR.
> +
> +Optional properties:
> +- linux,rc-map-name : Remote control map name.
> +
> +Example:
> +
> +ir0: ir at 01c21800 {
> +       	compatible = "allwinner,sun7i-a20-ir";
> +       	clocks = <&apb0_gates 6>, <&ir0_clk>;
> +       	clock-names = "apb0_ir0", "ir0";

Most of the time, we use something like "apb" and "ir". The names
being generic, if there ever comes a time where you have a second
controller, you don't have to do anything confusing or inconsistent.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140503/042ede1e/attachment-0001.sig>
