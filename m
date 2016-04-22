From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 Apr 2016 14:44:49 -0700
Subject: [PATCH v2 02/13] clk: Add {devm_}clk_hw_{register,unregister}()
 APIs
In-Reply-To: <1461277324-27185-3-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
 <1461277324-27185-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160422214449.GH13149@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21, Stephen Boyd wrote:
> We've largely split the clk consumer and provider APIs along
> struct clk and struct clk_hw, but clk_register() still returns a
> struct clk pointer for each struct clk_hw that's registered.
> Eventually we'd like to only allocate struct clks when there's a
> user, because struct clk is per-user now, so clk_register() needs
> to change.
> 
> Let's add new APIs to register struct clk_hws, but this time
> we'll hide the struct clk from the caller by returning an int
> error code. Also add an unregistration API that takes the clk_hw
> structure that was passed to the registration API. This way
> provider drivers never have to deal with a struct clk pointer
> unless they're using the clk consumer APIs.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
