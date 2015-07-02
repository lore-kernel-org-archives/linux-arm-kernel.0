From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 15:51:22 -0700
Subject: [PATCH v2 1/9] clk: rockchip: rk3288: add CLK_SET_RATE_PARENT to
 sclk_mac
In-Reply-To: <1434637116-17124-2-git-send-email-heiko@sntech.de>
References: <1434637116-17124-1-git-send-email-heiko@sntech.de>
 <1434637116-17124-2-git-send-email-heiko@sntech.de>
Message-ID: <20150702225122.GK4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Heiko Stuebner wrote:
> The dwmac ethernet controller on the rk3288 supports phys connected
> via rgmii and rmii. With rgmii phys it is expected that the mac clock
> is provided externally while with rmii phys the clock can be external
> but also generated from the plls. In the later case it of course needs
> be at 50MHz, which gets set from the dwmac_rk driver.
> As most devices use a rgmii phy it never surfaced so far that the mac
> clk mux, doesn't go up one lever to the pll clock in the rmii case with
> internal clock generation, as it is missing the CLK_SET_RATE_PARENT flag,
> and thus will not set the correct frequency in most cases.
> 
> Fixes: b9e4ba541607 ("clk: rockchip: add clock controller for rk3288")
> Cc: stable at vger.kernel.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
