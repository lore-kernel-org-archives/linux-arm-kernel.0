From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Jun 2017 17:25:34 -0700
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <20170628135345.9337-1-jbrunet@baylibre.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
Message-ID: <20170630002534.GF22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28, Jerome Brunet wrote:
> Current implementation of scpi_clk_add just print a warning when clock
> fails to register but then keep going as if nothing happened. The
> provider is then registered with bogus data.
> 
> This may latter lead to an Oops in __clk_create_clk when
> hlist_add_head(&clk->clks_node, &hw->core->clks) is called.
> 
> This patch fixes the issue and errors if a clock fails to register.
> 
> Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Control Processor)")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
