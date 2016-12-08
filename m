From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 14:55:12 -0800
Subject: [PATCH] clk: bcm2835: Avoid overwriting the div info when
 disabling a pll_div clk
In-Reply-To: <1480620441-5442-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480620441-5442-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20161208225512.GR5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01, Boris Brezillon wrote:
> bcm2835_pll_divider_off() is resetting the divider field in the A2W reg
> to zero when disabling the clock.
> 
> Make sure we preserve this value by reading the previous a2w_reg value
> first and ORing the result with A2W_PLL_CHANNEL_DISABLE.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> Cc: <stable@vger.kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
