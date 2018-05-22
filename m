From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 22 May 2018 17:28:26 +0100
Subject: [PATCH 7/8] arm64: tegra: Add nodes for tcu on Tegra194
In-Reply-To: <20180508114403.14499-8-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-8-mperttunen@nvidia.com>
Message-ID: <295c8125-6cdc-92b6-d0d7-01bf6ba0f8bd@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/05/18 12:44, Mikko Perttunen wrote:
> Add nodes required for communication through the Tegra Combined UART.
> This includes the AON HSP instance, addition of shared interrupts
> for the TOP0 HSP instance, and finally the TCU node itself. Also
> mark the HSP instances as compatible to tegra194-hsp, as the hardware
> is not identical but is compatible to tegra186-hsp.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6d699815a84f..d7f780b06fe2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -217,10 +217,31 @@
>   		};
>   
>   		hsp_top0: hsp at 3c00000 {
> -			compatible = "nvidia,tegra186-hsp";
> +			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";

I might be wrong, but I think we may need to update the binding doc 
compatibility property for hsp. For example see 
'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt'.

Cheers
Jon

-- 
nvpublic
