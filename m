From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Thu, 21 May 2015 12:42:23 +0000
Subject: [RFC PATCH 1/2] devicetree: Add devicetree bindings
 documentation for ZynqMP GQSPI
In-Reply-To: <20150520143854.GU31550@xsjsorenbubuntu>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150520143854.GU31550@xsjsorenbubuntu>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA6F1BC@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On Wed, 2015-05-20 at 12:57PM +0530, Ranjit Waghmode wrote:
> Add bindings documentation for GQSPI controller driver used by Zynq 
> Ultrascale+ MPSoC
> 
> Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
> ---
>  .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt 
> b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> new file mode 100644
> index 0000000..cec6330
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> @@ -0,0 +1,26 @@
> +Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
> +-------------------------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
> +- reg			: Physical base address and size of GQSPI registers map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number.
> +- interrupt-parent	: Must be core interrupt controller.
> +- clock-names		: List of input clock names - "ref_clk", "pclk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +
> +Optional properties:
> +- num-cs		: Number of chip selects used.
> +
> +Example:
> +	qspi: spi at ff0f0000 {
> +		compatible = "xlnx,zynqmp-qspi-1.0";
> +		clock-names = "ref_clk", "pclk";
> +		clocks = <&misc_clk &misc_clk>;
> +		interrupts = <0 15 4>;
> +		interrupt-parent = <&gic>;
> +		num-cs = <1>;
> +		reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;

I find things a lot easier to read when there is something separating the groups. Could this become:
	reg = <0x0 0xff0f0000 0x1000>, <0x0 0xc0000000 0x8000000>; ?

[Ranjit]: I will try your suggestion and send you in the next version.

Regards,
Ranjit
