From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 12:07:47 -0700
Subject: [PATCH RFC v1 2/5] clk: add missing lock when call clk_core_enable
 in clk_set_parent
In-Reply-To: <1429107999-24413-3-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-3-git-send-email-aisheng.dong@freescale.com>
Message-ID: <55427D83.3060900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/15 07:26, Dong Aisheng wrote:
> clk_core_enable is executed without &enable_clock in clk_set_parent function.
> Adding it to avoid potential race condition issue.
>
> Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---

Can you please describe the race condition? From what I can tell there
is not a race condition here and we've gone around on this part of the
code before to fix any race conditions.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
