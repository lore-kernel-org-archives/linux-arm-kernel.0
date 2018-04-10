From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Apr 2018 11:42:31 -0700
Subject: [PATCH] arm64: dts: apq8096-db820c: Add micro sd card supplies
In-Reply-To: <20180410135426.15508-1-srinivas.kandagatla@linaro.org>
References: <20180410135426.15508-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180410184231.GA23948@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 10 Apr 06:54 PDT 2018, Srinivas Kandagatla wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds missing microSD card supplies, without this uSD
> card will not be detected.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 1c8f1b86472d..f8191f64eb84 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -87,6 +87,8 @@
>  			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
>  			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  			cd-gpios = <&msmgpio 38 0x1>;
> +			vmmc-supply = <&pm8994_l21>;
> +			vqmmc-supply = <&pm8994_l13>;
>  			status = "okay";
>  		};
>  
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
