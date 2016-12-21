From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 14:04:56 -0800
Subject: [PATCH] arm64: dts: msm8996: Add required memory carveouts
In-Reply-To: <1482357822-20823-1-git-send-email-andy.gross@linaro.org>
References: <1482357822-20823-1-git-send-email-andy.gross@linaro.org>
Message-ID: <99427fc2-7d6f-af5f-6284-6ccb8f84d3f3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2016 02:03 PM, Andy Gross wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
>
> This patch adds required memory carveouts so that the kernel does not
> access memory that is in use or has been reserved for use by other remote
> processors.

Thanks,

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index cde4114..25e11dc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -64,6 +64,16 @@
>  			reg = <0x0 0x86000000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		memory at 85800000 {
> +			reg = <0x0 0x85800000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		memory at 86200000 {
> +			reg = <0x0 0x86200000 0x0 0x2600000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
