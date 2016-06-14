From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jun 2016 11:55:17 -0700
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160614185517.GG28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Linus Walleij wrote:
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index a5a38820554a..51d3c9e70617 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -215,6 +215,95 @@
> +
> +			rpmcc: clock-controller {
> +				compatible	= "qcom,rpmcc-apq8660", "qcom,rpmcc";
> +				#clock-cells = <1>;
> +			};

This driver isn't merged yet, but ok.

> +
> +			pm8901-regulators {

I'd rather have regulators at 8901 and regulators at 8058. That way the
node name is generic per ePAPR suggestions.

> +				compatible = "qcom,rpm-pm8901-regulators";
> +
> +				pm8901_l0: l0 {};
> +				pm8901_l1: l1 {};
> +				pm8901_l2: l2 {};
> +				pm8901_l3: l3 {};
> +				pm8901_l4: l4 {};
> +				pm8901_l5: l5 {};
> +				pm8901_l6: l6 {};
> +
> +				/* S0 and S1 Handled as SAW regulators by SPM */
> +				pm8901_s2: s2 {};
> +				pm8901_s3: s3 {};
> +				pm8901_s4: s4 {};
> +
> +				pm8901_lvs0: lvs0 {};
> +				pm8901_lvs1: lvs1 {};
> +				pm8901_lvs2: lvs2 {};
> +				pm8901_lvs3: lvs3 {};
> +
> +				pm8058_mvs: mvs {};

pm8901_mvs?

> +			};
> +
> +			pm8058-regulators {
> +				compatible = "qcom,rpm-pm8058-regulators";
> +
> +				pm8058_l0: l0 {};
> +				pm8058_l1: l1 {};
> +				pm8058_l2: l2 {};
> +				pm8058_l3: l3 {};
> +				pm8058_l4: l4 {};
> +				pm8058_l5: l5 {};
> +				pm8058_l6: l6 {};
> +				pm8058_l7: l7 {};
> +				pm8058_l8: l8 {};
> +				pm8058_l9: l9 {};
> +				pm8058_l10: l10 {};
> +				pm8058_l11: l11 {};
> +				pm8058_l12: l12 {};
> +				pm8058_l13: l13 {};
> +				pm8058_l14: l14 {};
> +				pm8058_l15: l15 {};
> +				pm8058_l16: l16 {};
> +				pm8058_l17: l17 {};
> +				pm8058_l18: l18 {};
> +				pm8058_l19: l19 {};
> +				pm8058_l20: l20 {};
> +				pm8058_l21: l21 {};
> +				pm8058_l22: l22 {};
> +				pm8058_l23: l23 {};
> +				pm8058_l24: l24 {};
> +				pm8058_l25: l25 {};
> +
> +				pm8058_s0: s0 {};
> +				pm8058_s1: s1 {};

Just leave these out? RPM shouldn't be touching s0 or s1.

> +				pm8058_s2: s2 {};
> +				pm8058_s3: s3 {};
> +				pm8058_s4: s4 {};
> +
> +				pm8058_lvs0: lvs0 {};
> +				pm8058_lvs1: lvs1 {};
> +
> +				pm8058_ncp: ncp {};
> +			};
> +		};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
