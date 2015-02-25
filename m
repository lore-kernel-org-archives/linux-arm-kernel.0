From: kwestfie@codeaurora.org (Kenneth Westfield)
Date: Wed, 25 Feb 2015 15:05:01 -0800
Subject: [PATCH] clk: qcom: Properly change rates for ahbix clock
In-Reply-To: <1424903527-5636-1-git-send-email-sboyd@codeaurora.org>
References: <1424903527-5636-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150225230500.GA28241@kwestfie-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:32:07PM -0800, Stephen Boyd wrote:
> The ahbix clock can never be turned off. To switch the rates we
> need to switch the mux off the M/N counter to an always on source
> (XO), reprogram the M/N counter to get the rate we want and
> finally switch back to the M/N counter. Add a new ops structure
> for this type of clock so that we can set the rate properly.
> 
> Fixes: c99e515a92e9 "clk: qcom: Add IPQ806X LPASS clock controller (LCC) driver"
> Cc: Kenneth Westfield <kwestfie@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/qcom/clk-rcg.c     | 30 ++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-rcg.h     |  1 +
>  drivers/clk/qcom/lcc-ipq806x.c |  5 +----
>  3 files changed, 32 insertions(+), 4 deletions(-)

Verified soundcard instantiation on the ipq806x SOC with max98357a codec.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
