From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 12:10:25 -0700
Subject: [PATCH v2 05/13] ARM: dts: db600c: add pmic regulator supplies
In-Reply-To: <1460453642-5809-6-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1460453642-5809-6-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <571682A1.9010000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 02:33 AM, Srinivas Kandagatla wrote:
> This patch adds pmic regulator supplies connected on the board.
> Rest of the invidual regulators would be added as and when required by
> the devices.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts | 62 +++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
> index 57d4500..6695b00 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
> @@ -9,7 +9,69 @@
>  		serial1 = &gsbi1_serial;
>  	};
>  
> +	regulators {
> +		compatible = "simple-bus";
> +		vph: regulator-fixed at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-min-microvolt = <4500000>;
> +			regulator-max-microvolt = <4500000>;
> +			regulator-name = "VPH";
> +			regulator-type = "voltage";
> +			regulator-boot-on;
> +		};
> +	};

Just curious why we added the vph supply? Is that for some framework
requirement? We haven't done this on other boards, although we probably
should if there's a good reason for it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
