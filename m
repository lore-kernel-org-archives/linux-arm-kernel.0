From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 29 May 2018 16:31:00 +0530
Subject: [PATCH v2] arm64: dts: qcom: msm8996: Move UFS_GDSC to UFS HCD
In-Reply-To: <20180525184525.355-1-bjorn.andersson@linaro.org>
References: <20180524223122.12601-1-bjorn.andersson@linaro.org>
 <20180525184525.355-1-bjorn.andersson@linaro.org>
Message-ID: <CAFp+6iGAhOyC8pM57rGNyVS_zpi3XBoZzcExY=BYVrWRgt4GLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2018 at 12:15 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The UFS_GDSC backs the resources needed by the UFS HCD, rather than the
> PHY. This results in the UFS HCD occationally failing to enable some of
> its clocks.
>
> Move the UFS_GDSC reference to the UFS HCD node instead, to correct
> this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Dropped UFS_GDSC from phy node
>
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 380e14591686..8c7f9ca25b53 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -654,8 +654,6 @@
>                         clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>                                  <&gcc GCC_UFS_CLKREF_CLK>;
>                         status = "disabled";
> -
> -                       power-domains = <&gcc UFS_GDSC>;
>                 };
>
>                 ufshc at 624000 {
> @@ -674,6 +672,8 @@
>                         vccq-max-microamp = <450000>;
>                         vccq2-max-microamp = <450000>;
>
> +                       power-domains = <&gcc UFS_GDSC>;
> +

Looks good.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Regards
Vivek
>                         clock-names =
>                                 "core_clk_src",
>                                 "core_clk",
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
