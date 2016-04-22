From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 Apr 2016 14:45:18 -0700
Subject: [PATCH v2 03/13] clk: Add clk_hw OF clk providers
In-Reply-To: <1461277324-27185-4-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
 <1461277324-27185-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160422214518.GI13149@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21, Stephen Boyd wrote:
> Now that we have a clk registration API that doesn't return
> struct clks, we need to have some way to hand out struct clks via
> the clk_get() APIs that doesn't involve associating struct clk
> pointers with an OF node. Currently we ask the OF provider to
> give us a struct clk pointer for some clkspec, turn that struct
> clk into a struct clk_hw and then allocate a new struct clk to
> return to the caller.
> 
> Let's add a clk_hw based OF provider hook that returns a struct
> clk_hw directly, so that we skip the intermediate step of
> converting from struct clk to struct clk_hw. Eventually when
> we've converted all OF clk providers to struct clk_hw based APIs
> we can remove the struct clk based ones.
> 
> It should also be noted that we change the onecell provider to
> have a flex array instead of a pointer for the array of clk_hw
> pointers. This allows providers to allocate one structure of the
> correct length in one step instead of two.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
