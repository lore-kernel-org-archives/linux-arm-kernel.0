From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 2 Dec 2015 23:31:23 -0800
Subject: [PATCH v2] clk: sunxi: pll2: Fix clock running too fast
In-Reply-To: <1448968492-28979-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1448968492-28979-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151203073123.GD14699@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01, Maxime Ripard wrote:
> Contrary to what the datasheet says, the pre divider doesn't seem to be
> incremented by one in the PLL2, but just uses the value from the register,
> with 0 being a bypass.
> 
> This fixes the audio playing too fast.
> 
> Since we now have the same pre-divider flags, and the only difference with
> the A10 is the post-divider offset, also remove the structure to just pass
> the offset as an argument.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Applied to clk-fixes + I added the Fixes tag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
