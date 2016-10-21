From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Oct 2016 17:04:08 -0700
Subject: [PATCH v2 3/4] arm64: dts: msm8996: Add SMEM DT nodes
In-Reply-To: <1477005139-15564-4-git-send-email-spjoshi@codeaurora.org>
References: <1477005139-15564-1-git-send-email-spjoshi@codeaurora.org>
 <1477005139-15564-4-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20161021000408.GI26139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20, Sarangdhar Joshi wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add SMEM and TCSR DT nodes on MSM8996.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 949b096..abc1089 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -164,17 +164,36 @@
>  
>  	};
>  
> +	tcsr_mutex: hwlock {
> +		compatible = "qcom,tcsr-mutex";
> +		syscon = <&tcsr_mutex_regs 0 0x1000>;
> +		#hwlock-cells = <1>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
>  	};
>  
> +	smem {
> +		compatible = "qcom,smem";
> +
> +		memory-region = <&smem_mem>;
> +
> +		hwlocks = <&tcsr_mutex 3>;

Super nitpick: Is there a reason we have newlines between
everything in this node? This node is the only one that isn't
consistent.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
