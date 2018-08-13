From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Aug 2018 13:07:21 -0600
Subject: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas
 documentation
In-Reply-To: <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
Message-ID: <20180813190721.GA27621@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 12:00:09AM +0200, Maxime Jourdan wrote:
> DT bindings doc for amlogic,meson-canvas
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> new file mode 100644
> index 000000000000..5f0351717bee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> @@ -0,0 +1,36 @@
> +Amlogic Canvas
> +================================
> +
> +A canvas is a collection of metadata that describes a pixel buffer.
> +Those metadata include: width, height, phyaddr, wrapping, block mode
> +and endianness.
> +
> +Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
> +rather than use the phy addresses directly. For instance, this is the case for
> +the video decoders and the display.
> +
> +Amlogic SoCs have 256 canvas.
> +
> +Device Tree Bindings:
> +---------------------
> +
> +Canvas Provider
> +--------------------------
> +
> +Required properties:
> +- compatible: "amlogic,canvas"
> +
> +Parent node should have the following properties :
> +- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"

Is this documented somewhere? One child function is not a reason for an 
MFD and child nodes. And child nodes like this with no resources are 
unnecessary.

> +- reg: base address and size of the DMC system control register space.
> +
> +Example:
> +
> +sysctrl_DMC: system-controller at 0 {
> +	compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
> +	reg = <0x0 0x0 0x0 0x1000>;
> +
> +	canvas: canvas-provider at 0 {
> +		compatible = "amlogic,canvas";
> +	};
> +};
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
