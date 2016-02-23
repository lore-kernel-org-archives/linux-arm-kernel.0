From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Feb 2016 16:15:08 -0800
Subject: [PATCHv2] clk: ti: dpll: convert DPLL support code to use clk_hw
 instead of clk ptrs
In-Reply-To: <1455967466-3812-1-git-send-email-t-kristo@ti.com>
References: <1455967466-3812-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160223001507.GC4847@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20, Tero Kristo wrote:
> Convert DPLL support code to use clk_hw pointers for reference and bypass
> clocks. This allows us to use clk_hw_* APIs for accessing any required
> parameters for these clocks, avoiding some locking problems at least with
> DPLL enable code; this used clk_get_rate which uses mutex but isn't
> good under clk_enable / clk_disable.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
