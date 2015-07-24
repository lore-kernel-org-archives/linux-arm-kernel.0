From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 24 Jul 2015 06:40:43 +0200
Subject: [RFC 1/3] docs: dts: Added documentation for Xilinx Zynq PL Reset
 bindings.
In-Reply-To: <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
 <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <55B1C1CB.2050402@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2015 12:51 AM, Moritz Fischer wrote:
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

I think there is no reason to be just PL specific.
> +
> +Required properties:
> +- compatible: "xlnx,zynq-reset-pl"
> +- syscon <&slcr>;
> +- #reset-cells: 1
> +
> +Example:
> +	rstc: rstc at 240 {

@200 then here

> +		#reset-cells = <1>;
> +		compatible = "xlnx,zynq-reset-pl";

Compatible should be first below node name.

You should add also reg property 0x200 0x50

> +		syscon = <&slcr>;
> +	};
> 

Thanks,
Michal
