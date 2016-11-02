From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:30:58 -0700
Subject: [PATCH] clk: lpc32xx: add a quirk for PWM and MS clock dividers
In-Reply-To: <1475803015-4067-1-git-send-email-vz@mleia.com>
References: <1475803015-4067-1-git-send-email-vz@mleia.com>
Message-ID: <20161102003058.GH16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07, Vladimir Zapolskiy wrote:
> In common clock framework CLK_DIVIDER_ONE_BASED or'ed with
> CLK_DIVIDER_ALLOW_ZERO flags indicates that
> 1) a divider clock may be set to zero value,
> 2) divider's zero value is interpreted as a non-divided clock.
> 
> On the LPC32xx platform clock dividers of PWM and memory card clocks
> comply with the first condition, but zero value means a gated clock,
> thus it may happen that the divider value is not updated when
> the clock is enabled and the clock remains gated.
> 
> The change adds one-shot quirks, which check for zero value of divider
> on initialization and set it to a non-zero value, therefore in runtime
> a gate clock will work as expected.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
