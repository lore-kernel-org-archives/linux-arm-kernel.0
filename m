From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 5 Mar 2018 10:12:21 +0530
Subject: [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180302215638.6145-3-jcrouse@codeaurora.org>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
Message-ID: <20180305044221.GC23018@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-03-18, 14:56, Jordan Crouse wrote:
> Add the nodes and other bits to describe the Adreno GPU and GMU
> devices.
> 
> Change-Id: Ibf4dc0ebb0ac03d8b6b8e65747e142c440e70b0a

Remove it ?

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 120 +++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 7b5c16eb63b7..cc6d367ee55e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -312,5 +312,125 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		adreno_smmu: arm,smmu-adreno at 5040000 {
> +			compatible = "qcom,msm8996-smmu-v2";
> +			reg = <0x5040000 0x10000>;
> +			#iommu-cells = <1>;
> +			#global-interrupts = <2>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&clock_gcc GCC_GPU_CFG_AHB_CLK>;
> +			clock-names = "bus", "iface";
> +
> +			power-domains = <&clock_gpucc GPU_CX_GDSC>;
> +		};
> +
> +		gpu_opp_table: adreno-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-710000000 {
> +				opp-hz = /bits/ 64 <710000000>;
> +				qcom,arc-level = <416>;

I am not sure if I saw where this is defined ?


-- 
viresh
