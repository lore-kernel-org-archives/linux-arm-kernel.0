From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 28 Jul 2015 10:05:02 +0200
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq
 Reset Controller bindings.
In-Reply-To: <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1438070702.3193.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 24.07.2015, 17:21 -0700 schrieb Moritz Fischer:
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

Why the syscon phandle if rstc always is the child of slcr? Why not just
request the syscon for the rstc's parent node.

> +	};

regards
Philipp
