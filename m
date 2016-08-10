From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Aug 2016 15:06:14 -0700
Subject: [PATCH] clk: sunxi-ng: Fix inverted test condition in
 ccu_helper_wait_for_lock
In-Reply-To: <20160715080636.GP4761@lukather>
References: <1468464155-11888-1-git-send-email-wens@csie.org>
 <20160715080636.GP4761@lukather>
Message-ID: <20160810220614.GE2996@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15, Maxime Ripard wrote:
> On Thu, Jul 14, 2016 at 10:42:35AM +0800, Chen-Yu Tsai wrote:
> > The condition passed to read*_poll_timeout() is the break condition,
> > i.e. wait for this condition to happen and return success.
> > 
> > The original code assumed the opposite, resulting in a warning when
> > the PLL clock rate was changed but never lost it's lock as far as
> > the readout indicated. This was verified by checking the read out
> > register value.
> > 
> > Fixes: 1d80c14248d6 ("clk: sunxi-ng: Add common infrastructure")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Mike, Stephen, could you add that patch on top of the current branch?
> 

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
