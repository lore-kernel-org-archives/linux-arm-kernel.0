From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 16:51:18 -0700
Subject: [PATCH v2] clk: mvebu: armada-37xx-tbg: Switch to clk_get and
 balance it in probe
In-Reply-To: <20181010181838.26923-1-gregory.clement@bootlin.com>
References: <20181010181838.26923-1-gregory.clement@bootlin.com>
Message-ID: <153973387816.5275.3801197644507437368@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-10-10 11:18:38)
> The parent clock is get only to have its name, and then the clock is no
> more used, so we can safely free it using clk_put. Furthermore as between
> the successful devm_clk_get() and the devm_clk_put() call we don't exit
> the probe function in error so I can use non managed version of clk_get()
> and clk_put().
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next
