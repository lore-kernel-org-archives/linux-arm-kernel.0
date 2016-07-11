From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:05:19 -0700
Subject: [PATCH] firmware: qcom: scm: Change initcall to subsys
In-Reply-To: <1467433214-7667-1-git-send-email-andy.gross@linaro.org>
References: <1467433214-7667-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20160711210519.GB16764@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01, Andy Gross wrote:
> The patch changes the initcall for SCM to use subsys_initcall
> instead of arch_initcall.  This corrects the order so that we don't
> probe defer when trying to get clks which causes issues later when
> the spm driver makes calls to qcom_set_warm_boot_addr().
> 
> The order became an issue due to the changes to use arch_initcall_sync
> for of_platform_default_populate_init().
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
