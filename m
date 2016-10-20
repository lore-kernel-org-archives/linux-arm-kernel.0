From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 20 Oct 2016 12:57:43 -0700
Subject: [PATCH 1/4] arm64: dts: msm8996: Add SMEM reserve-memory node
In-Reply-To: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
References: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20161020195743.GO7509@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 20 Oct 11:56 PDT 2016, Sarangdhar Joshi wrote:

> Add DT node to carveout memory for shared memory region.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index d6da223..36216ae 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -31,6 +31,17 @@
>  		reg = <0 0 0 0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		smem_mem: smem-mem at 86000000 {
> +			reg = <0x0 0x86000000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
