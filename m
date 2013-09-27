From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Sep 2013 09:15:06 +0800
Subject: [PATCH 1/2] Documentation: Add device tree bindings for i.MX TVE
In-Reply-To: <1380192374-9531-1-git-send-email-p.zabel@pengutronix.de>
References: <1380192374-9531-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130927011504.GA25146@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 12:46:13PM +0200, Philipp Zabel wrote:
> This patch adds device tree binding documentation for i.MX Television Encoder
> devices contained in i.MX51 and i.MX53 SoCs.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/video/fsl,imx-tve.txt      | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-tve.txt

Shouldn't this be put into
Documentation/devicetree/bindings/staging/imx-drm/?

Shawn

> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-tve.txt b/Documentation/devicetree/bindings/video/fsl,imx-tve.txt
> new file mode 100644
> index 0000000..77f92d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-tve.txt
> @@ -0,0 +1,23 @@
> +Freescale i.MX Television Encoder (TVE, TVEv2)
> +
> +The TVE encoders are contained in i.MX51 and i.MX53 SoCs and can drive analog
> +output connectors such as VGA, Composite, or S-Video.
> +
> +Required properties:
> +- compatible : "fsl,<soc>-tve", soc should be imx51 or imx53
> +- reg : Should contain 1 register ranges(address and length)
> +- interrupts : One interrupt of the fb dev
> +- clocks, clock-names : Phandles to clocks called "tve" and "di_sel"
> +  as documented in Documentation/devicetree/bindings/clock/clock-bindings.txt.
> +  di_sel is a display interface input clock multiplexer, which can
> +  be parented to the tve_di output clock provided by this device.
> +
> +Example:
> +
> +	tve: tve at 63ff0000 {
> +		compatible = "fsl,imx53-tve";
> +		reg = <0x63ff0000 0x1000>;
> +		interrupts = <92>;
> +		clocks = <&clks 69>, <&clks 116>;
> +		clock-names = "tve", "di_sel";
> +	};
> -- 
> 1.8.4.rc3
> 
