From: kwestfie@codeaurora.org (Kenneth Westfield)
Date: Wed, 11 Mar 2015 20:42:34 -0700
Subject: [PATCH v2] clk: qcom: Properly change rates for ahbix clock
In-Reply-To: <1425685313-6005-1-git-send-email-sboyd@codeaurora.org>
References: <1425685313-6005-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150312034234.GA22530@kwestfie-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 03:41:53PM -0800, Stephen Boyd wrote:
> The ahbix clock can never be turned off in practice. To change the
> rates we need to switch the mux off the M/N counter to an always on
> source (XO), reprogram the M/N counter to get the rate we want and
> finally switch back to the M/N counter. Add a new ops structure
> for this type of clock so that we can set the rate properly.
> 
> Fixes: c99e515a92e9 "clk: qcom: Add IPQ806X LPASS clock controller (LCC) driver"
> Cc: Kenneth Westfield <kwestfie@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes from v1:
>  * Handle the case where clock feeding M/N counter is off
> 
>  drivers/clk/qcom/clk-rcg.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-rcg.h     |  1 +
>  drivers/clk/qcom/lcc-ipq806x.c |  5 ++--
>  3 files changed, 65 insertions(+), 3 deletions(-)

Verified I2S audio functionality on the Storm board; with and without
firmware audio enabled.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
