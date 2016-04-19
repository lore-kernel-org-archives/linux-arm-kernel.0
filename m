From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 14:04:23 -0700
Subject: [PATCH v2 2/2] clk: bcm2835: Fix PLL poweron
In-Reply-To: <1460577903-32192-2-git-send-email-eric@anholt.net>
References: <1460577903-32192-1-git-send-email-eric@anholt.net>
 <1460577903-32192-2-git-send-email-eric@anholt.net>
Message-ID: <20160419210423.GE15324@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13, Eric Anholt wrote:
> In poweroff, we set the reset bit and the power down bit, but only
> managed to unset the reset bit for poweron.  This meant that if HDMI
> did -EPROBE_DEFER after it had grabbed its clocks, we'd power down the
> PLLH (that had been on at boot time) and never recover.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> Cc: stable at vger.kernel.org
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
