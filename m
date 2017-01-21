From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:23:44 -0800
Subject: [PATCH v2 1/3] clk: bcm2835: Don't rate change PLLs on behalf of
 DSI PLL dividers.
In-Reply-To: <20170117203157.23822-1-eric@anholt.net>
References: <20170117203157.23822-1-eric@anholt.net>
Message-ID: <20170121002344.GM20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Eric Anholt wrote:
> Our core PLLs are intended to be configured once and left alone.  With
> the SET_RATE_PARENT, asking to set the PLLD_DSI1 clock rate would
> change PLLD just to get closer to the requested DSI clock, thus
> changing PLLD_PER, the UART and ethernet PHY clock rates downstream of
> it, and breaking ethernet.
> 
> We *do* want PLLH to change so that PLLH_AUX can be exactly the value
> we want, though.  Thus, we need to have a per-divider policy of
> whether to pass rate changes up.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
