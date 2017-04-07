From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Apr 2017 12:22:13 -0700
Subject: [PATCH 2/3] zte: clk: pd_bit is not 0 on zx296718
In-Reply-To: <1490085503-15713-3-git-send-email-shawnguo@kernel.org>
References: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
 <1490085503-15713-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170407192213.GZ7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The bit 0 of PLL_CFG0 register is not powerdown on zx296718, but part of
> of postdiv2 field.  The consequence is that functions like hw_to_idx()
> and zx_pll_enable() will end up tampering the postdiv2 of the PLL.
> 
> Let's fix it by defining pd_bit 0xff which is obviously invalid for a
> bit position and having PLL driver check the validity before operating
> on the bit.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
