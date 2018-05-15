From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 15 May 2018 09:41:24 +0530
Subject: [PATCH v6 14/14] dt: qcom: Add qcom-cpufreq-kryo driver
 configuration
In-Reply-To: <1526303520-5843-15-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-15-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180515041124.7e7qkzqd2jkokqhz@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-05-18, 16:12, Ilia Lin wrote:
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi       | 310 +++++++++++++++++++++++++++-
>  2 files changed, 309 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 230e9c8..da23bda 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -17,5 +17,5 @@
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. DB820c";
> -	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
> +	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index d7adef9..fbf92f6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -174,218 +174,519 @@
>  	};
>  
>  	cluster0_opp: opp_table0 {
> -		compatible = "operating-points-v2";
> +		compatible = "operating-points-v2-kryo-cpu";

I think you need to mention both the above compatible strings here
with the kyro one mentioned first.


-- 
viresh
