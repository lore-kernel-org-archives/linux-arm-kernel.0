From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 12:09:18 -0700
Subject: [PATCH RFC v1 3/5] clk: remove unneeded __clk_enable and
 __clk_disable
In-Reply-To: <1429107999-24413-4-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-4-git-send-email-aisheng.dong@freescale.com>
Message-ID: <55427DDE.4090907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/15 07:26, Dong Aisheng wrote:
> The only thing __clk_enable/__clk_disable does is NULL pointer checking
> of clk except calling clk_core_{enable|disable} which is already handled
> by clk_core_{enable|disable}.
> So remove this unneeded function.
>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---

No. You can call clk_enable() and clk_disable() with NULL and it should
be a no-op. With this change it would cause a NULL pointer exception.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
