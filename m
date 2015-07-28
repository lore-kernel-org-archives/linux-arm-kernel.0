From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 27 Jul 2015 19:58:33 -0700
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20150728025833.GQ2650@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

On Fri, 2015-07-24 at 05:21PM -0700, Moritz Fischer wrote:
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

I think you also have to add the outputs and make them part of the
binding. Otherwise you'd have to read the implementation to find
out what device should be hooked up to which output of the reset-controller.

	S?ren
