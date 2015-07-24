From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 24 Jul 2015 09:25:23 +0200
Subject: [RFC 1/3] docs: dts: Added documentation for Xilinx Zynq PL
 Reset bindings.
In-Reply-To: <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
 <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1437722723.3834.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 23.07.2015, 15:51 -0700 schrieb Moritz Fischer:
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> new file mode 100644
> index 0000000..ac4499e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> @@ -0,0 +1,13 @@
> +Xilinx Zynq PL Reset Manager
> +
> +Required properties:
> +- compatible: "xlnx,zynq-reset-pl"
> +- syscon <&slcr>;
> +- #reset-cells: 1
> +
> +Example:
> +	rstc: rstc at 240 {
> +		#reset-cells = <1>;
> +		compatible = "xlnx,zynq-reset-pl";
> +		syscon = <&slcr>;
> +	};

Instead of the syscon property, why not specify that the rstc node must
be a child of the slcr node?

regards
Philipp
