From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:43:10 -0700
Subject: [PATCH] clk: hi6220: use CLK_OF_DECLARE_DRIVER for sysctrl and
 mediactrl clock init
In-Reply-To: <1475933892-16021-1-git-send-email-shawn.guo@linaro.org>
References: <1475933892-16021-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20161017224310.GM8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08, Shawn Guo wrote:
> The hi6220-sysctrl and hi6220-mediactrl are not only clock provider but
> also reset controller.  It worked fine that single sysctrl/mediactrl
> device node in DT can be used to initialize clock driver and populate
> platform device for reset controller.  But it stops working after
> commit 989eafd0b609 ("clk: core: Avoid double initialization of clocks")
> gets merged.  The commit sets flag OF_POPULATED during clock
> initialization to skip the platform device populating for the same
> device node.  On hi6220, it effectively makes hi6220-sysctrl reset
> driver not probe any more.
> 
> The patch changes hi6220 sysctrl and mediactrl clock init macro from
> CLK_OF_DECLARE to CLK_OF_DECLARE_DRIVER, so that the reset driver using
> the same hardware block can continue working.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
