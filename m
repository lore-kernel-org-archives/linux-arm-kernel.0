From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Sep 2014 11:18:20 -0700
Subject: [PATCH] clk: qcom: Add IPQ8064 PLL required for USB
In-Reply-To: <1410754332-26699-1-git-send-email-agross@codeaurora.org>
References: <1410754332-26699-1-git-send-email-agross@codeaurora.org>
Message-ID: <54172D6C.10902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/14 21:12, Andy Gross wrote:
>  static struct clk_pll pll3 = {
>  	.l_reg = 0x3164,
>  	.m_reg = 0x3168,
> @@ -155,6 +182,7 @@ static const char *gcc_pxo_pll8_pll0_map[] = {
>  	"pxo",
>  	"pll8_vote",
>  	"pll0",
> +	"pll0_vote",
>  };

This is wrong. We should be removing pll0 and adding pll0_vote.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
