From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 17 Jan 2014 13:40:03 -0800
Subject: [PATCH] clk: qcom: Fix modular build
In-Reply-To: <1389989380-17441-1-git-send-email-sboyd@codeaurora.org>
References: <52d8dde8.Mqtb7njO7G6foYTt%fengguang.wu@intel.com>
 <1389989380-17441-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140117214003.4167.53304@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-01-17 12:09:40)
> According to Documentation/kbuild/makefiles.txt these symbols
> should be clk-qcom-y. Otherwise the build will fail if
> CONFIG_COMMON_CLK_QCOM=m. Fix it.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/qcom/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 190d38433202..f60db2ef1aee 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -1,11 +1,11 @@
>  obj-$(CONFIG_COMMON_CLK_QCOM) += clk-qcom.o
>  
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += clk-regmap.o
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += clk-pll.o
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += clk-rcg.o
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += clk-rcg2.o
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += clk-branch.o
> -clk-qcom-$(CONFIG_COMMON_CLK_QCOM) += reset.o
> +clk-qcom-y += clk-regmap.o
> +clk-qcom-y += clk-pll.o
> +clk-qcom-y += clk-rcg.o
> +clk-qcom-y += clk-rcg2.o
> +clk-qcom-y += clk-branch.o
> +clk-qcom-y += reset.o
>  
>  obj-$(CONFIG_MSM_GCC_8660) += gcc-msm8660.o
>  obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
