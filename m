From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 May 2016 17:37:16 -0700
Subject: [PATCH v2 04/13] clkdev: Add clk_hw based registration APIs
In-Reply-To: <1461277324-27185-5-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
 <1461277324-27185-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160503003716.GH3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21, Stephen Boyd wrote:
> Now that we have a clk registration API that doesn't return
> struct clks, we need to have some way to hand out struct clks via
> the clk_get() APIs that doesn't involve associating struct clk
> pointers with a struct clk_lookup. Luckily, clkdev already
> operates on struct clk_hw pointers, except for the registration
> facing APIs where it converts struct clk pointers into struct
> clk_hw pointers almost immediately.
> 
> Let's add clk_hw based registration APIs so that we can skip the
> conversion step and provide a way for clk provider drivers to
> operate exclusively on clk_hw structs. This way we clearly
> split the API between consumers and providers.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
