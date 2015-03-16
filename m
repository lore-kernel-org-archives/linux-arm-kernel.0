From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Mar 2015 14:59:12 +0530
Subject: [PATCH v7 3/3] Documentation: dma: Add APM X-Gene SoC DMA engine
 driver documentation
In-Reply-To: <1426158921-8987-4-git-send-email-rsahu@apm.com>
References: <1426158921-8987-1-git-send-email-rsahu@apm.com>
 <1426158921-8987-4-git-send-email-rsahu@apm.com>
Message-ID: <20150316092912.GI32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 04:45:21PM +0530, Rameshwar Prasad Sahu wrote:
> This patch adds device tree binding for APM X-Gene SoC DMA engine driver.
The patch title should be to add the bindings and not Documentation

-- 
~Vinod
> 
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/dma/apm-xgene-dma.txt      | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
> new file mode 100644
> index 0000000..d305876
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
> @@ -0,0 +1,47 @@
> +Applied Micro X-Gene SoC DMA nodes
> +
> +DMA nodes are defined to describe on-chip DMA interfaces in
> +APM X-Gene SoC.
> +
> +Required properties for DMA interfaces:
> +- compatible: Should be "apm,xgene-dma".
> +- device_type: set to "dma".
> +- reg: Address and length of the register set for the device.
> +  It contains the information of registers in the following order:
> +  1st - DMA control and status register address space.
> +  2nd - Descriptor ring control and status register address space.
> +  3rd - Descriptor ring command register address space.
> +  4th - Soc efuse register address space.
> +- interrupts: DMA has 5 interrupts sources. 1st interrupt is
> +  DMA error reporting interrupt. 2nd, 3rd, 4th and 5th interrupts
> +  are completion interrupts for each DMA channels.
> +- clocks: Reference to the clock entry.
> +
> +Optional properties:
> +- dma-coherent : Present if dma operations are coherent
> +
> +Example:
> +	dmaclk: dmaclk at 1f27c000 {
> +		compatible = "apm,xgene-device-clock";
> +		#clock-cells = <1>;
> +		clocks = <&socplldiv2 0>;
> +		reg = <0x0 0x1f27c000 0x0 0x1000>;
> +		reg-names = "csr-reg";
> +		clock-output-names = "dmaclk";
> +	};
> +
> +	dma: dma at 1f270000 {
> +			compatible = "apm,xgene-storm-dma";
> +			device_type = "dma";
> +			reg = <0x0 0x1f270000 0x0 0x10000>,
> +			      <0x0 0x1f200000 0x0 0x10000>,
> +			      <0x0 0x1b008000 0x0 0x2000>,
> +			      <0x0 0x1054a000 0x0 0x100>;
> +			interrupts = <0x0 0x82 0x4>,
> +				     <0x0 0xb8 0x4>,
> +				     <0x0 0xb9 0x4>,
> +				     <0x0 0xba 0x4>,
> +				     <0x0 0xbb 0x4>;
> +			dma-coherent;
> +			clocks = <&dmaclk 0>;
> +	};
> --
> 1.8.2.1
> 

-- 
