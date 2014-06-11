From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 11 Jun 2014 11:14:09 +0200
Subject: [PATCH 1/2] clk: qcom: add clocks necessary for apq8064 sdcc
In-Reply-To: <1402433906-19309-2-git-send-email-sboyd@codeaurora.org>
References: <1402433906-19309-1-git-send-email-sboyd@codeaurora.org>
 <1402433906-19309-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <53981DE1.3070007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.06.2014 22:58, schrieb Stephen Boyd:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds clocks necessary for SD card controller on apq8064 SOC.
> Without this patch the clocks are visible to the sdcc driver.

Was this maybe meant to read "invisible"?

Regards,
Andreas

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8960.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
> index f4ffd91901f8..c47a75829b2b 100644
> --- a/drivers/clk/qcom/gcc-msm8960.c
> +++ b/drivers/clk/qcom/gcc-msm8960.c
> @@ -2876,6 +2876,14 @@ static struct clk_regmap *gcc_apq8064_clks[] = {
>  	[GSBI7_QUP_SRC] = &gsbi7_qup_src.clkr,
>  	[GSBI7_QUP_CLK] = &gsbi7_qup_clk.clkr,
>  	[GSBI7_H_CLK] = &gsbi7_h_clk.clkr,
> +	[SDC1_SRC] = &sdc1_src.clkr,
> +	[SDC1_CLK] = &sdc1_clk.clkr,
> +	[SDC2_SRC] = &sdc2_src.clkr,
> +	[SDC2_CLK] = &sdc2_clk.clkr,
> +	[SDC3_SRC] = &sdc3_src.clkr,
> +	[SDC3_CLK] = &sdc3_clk.clkr,
> +	[SDC4_SRC] = &sdc4_src.clkr,
> +	[SDC4_CLK] = &sdc4_clk.clkr,
>  };
>  
>  static const struct regmap_config gcc_msm8960_regmap_config = {
> 


-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
