From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 23:17:26 -0700
Subject: [PATCH 1/3] arm64: dts: qcom: msm8996: add support to pcie
In-Reply-To: <20170814113420.30866-1-srinivas.kandagatla@linaro.org>
References: <20170814113420.30866-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171011061726.GO1165@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 14 Aug 04:34 PDT 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to 3 pcie root complexes found on MSM8996.
> 
[..]
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
[..]
> +		agnoc at 0 {
> +			power-domains = <&gcc AGGRE0_NOC_GDSC>;
> +			compatible = "simple-pm-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;

I also need to enable GCC_AGGRE0_SNOC_AXI_CLK, GCC_AGGRE0_CNOC_AHB_CLK
and GCC_SMMU_AGGRE0_AXI_CLK for pcie to actually work. It find the
atl1c, but the board restarts as the interface is brought up.

Regards,
Bjorn
