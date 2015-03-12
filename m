From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Mar 2015 17:43:21 -0700
Subject: [PATCH v2] clk: qcom: Properly change rates for ahbix clock
In-Reply-To: <1425685313-6005-1-git-send-email-sboyd@codeaurora.org>
References: <1425685313-6005-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5500E129.2060602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 15:41, Stephen Boyd wrote:
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
>

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
