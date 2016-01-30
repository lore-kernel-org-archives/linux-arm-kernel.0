From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 17:41:43 -0800
Subject: [PATCH] clk: ti: dpll: convert DPLL support code to use clk_hw
 instead of clk ptrs
In-Reply-To: <1453981451-9054-1-git-send-email-t-kristo@ti.com>
References: <1453981451-9054-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160130014143.GH4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Tero Kristo wrote:
> Convert DPLL support code to use clk_hw pointers for reference and bypass
> clocks. This allows us to use clk_hw_* APIs for accessing any required
> parameters for these clocks, avoiding some locking problems at least with
> DPLL enable code; this used clk_get_rate which uses mutex but isn't
> good under clk_enable / clk_disable.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Looks good.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
