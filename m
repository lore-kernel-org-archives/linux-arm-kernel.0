From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jun 2016 15:15:01 -0700
Subject: [Patch v5 3/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1463111221-6963-4-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160602221501.GO28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12, Andy Gross wrote:
> This patch changes the cold_set_boot_addr function to use atomic SCM
> calls.  cold_set_boot_addr required adding qcom_scm_call_atomic2 to
> support the two arguments going to the smc call.  Using atomic removes
> the need for memory allocation and instead places all arguments in
> registers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
