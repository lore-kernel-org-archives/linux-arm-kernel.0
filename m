From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 28 Apr 2014 23:51:14 -0700
Subject: [PATCH] clk: qcom: Various fixes for MSM8960's global clock
 controller
In-Reply-To: <1396629176-7413-1-git-send-email-galak@codeaurora.org>
References: <1396629176-7413-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140429065114.7224.13620@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kumar Gala (2014-04-04 09:32:56)
> * Remove CE2_SLEEP_CLK, doesn't exist on 8960 family SoCs
> * Fix incorrect offset for PMIC_SSBI2_RESET
> * Fix typo:
>         SIC_TIC -> SPS_TIC_H
>         SFAB_ADM0_M2_A_CLK -> SFAB_ADM0_M2_H_CLK
> * Fix naming convention:
>         SFAB_CFPB_S_HCLK -> SFAB_CFPB_S_H_CLK
>         SATA_SRC_CLK -> SATA_CLK_SRC

I'll take these through clk-next instead of clk-fixes since there is no
mention of a regression.

<snip>

> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8960.h b/include/dt-bindings/clock/qcom,gcc-msm8960.h
> index 03bbf49..f9f5471 100644
> --- a/include/dt-bindings/clock/qcom,gcc-msm8960.h
> +++ b/include/dt-bindings/clock/qcom,gcc-msm8960.h
> @@ -51,7 +51,7 @@
>  #define QDSS_TSCTR_CLK                         34
>  #define SFAB_ADM0_M0_A_CLK                     35
>  #define SFAB_ADM0_M1_A_CLK                     36
> -#define SFAB_ADM0_M2_A_CLK                     37
> +#define SFAB_ADM0_M2_H_CLK                     37

Technically these changes break backwards compatibility, but I guess
that field updates to newer kernel images for this SoC are not a
concern?

Thanks,
Mike
