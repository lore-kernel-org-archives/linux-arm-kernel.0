From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 19 Sep 2018 14:30:59 +0100
Subject: [PATCH 16/21] arm64: dts: ls1046a: add smmu node
In-Reply-To: <20180919123613.15092-17-laurentiu.tudor@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-17-laurentiu.tudor@nxp.com>
Message-ID: <a4d32163-71b1-35df-3a4c-eb27b605fc46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/18 13:36, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This allows for the SMMU device to be probed by the SMMU kernel driver.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index ef83786b8b90..06863d3e4a7d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -228,6 +228,48 @@
>   			bus-width = <4>;
>   		};
>   
> +		mmu: iommu at 9000000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0 0x9000000 0 0x400000>;
> +			dma-coherent;
> +			#global-interrupts = <2>;
> +			#iommu-cells = <1>;
> +			interrupts = <0 142 4>, /* global secure fault */

Either that's not really the secure global interrupt, or those context 
interrupts are wrong.

Robin.

> +				     <0 143 4>, /* combined secure interrupt */
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>;
> +		};
> +
>   		scfg: scfg at 1570000 {
>   			compatible = "fsl,ls1046a-scfg", "syscon";
>   			reg = <0x0 0x1570000 0x0 0x10000>;
> 
