From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 15:45:16 -0600
Subject: [PATCH 2/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
In-Reply-To: <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20180716214516.GA31738@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 03:21:49PM +0200, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/soc/amlogic/clk-measure.txt       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> new file mode 100644
> index 0000000..ba9183a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> @@ -0,0 +1,15 @@
> +Amlogic Internal Clock Measurer
> +===============================
> +
> +The Amlogic SoCs contains an IP to measure the internal clocks.
> +The precision is multiple of MHz, useful to debug the clock states.

What a simple yet useful debug tool.

> +
> +Required properties:
> +- compatible: Shall contain "amlogic,meson-gx-clk-measure"
> +- reg: base address and size of the Clock Measurer register space.
> +
> +Example:
> +	clock-measure at 8758 {
> +		compatible = "amlogic,meson-gx-clk-measure";
> +		reg = <0x0 0x8758 0x0 0x10>;

This doesn't really look like its own block though. Can't the parent 
device instantiate the driver for this?


> +	};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
