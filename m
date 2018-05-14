From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon, 14 May 2018 23:16:07 +0200
Subject: [RFC PATCH 07/10] clk: rockchip: set clk-ddr to GET_RATE_NOCACHE.
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Message-ID: <20180514211610.26618-8-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Derek Basehore <dbasehore@chromium.org>

This adds the flag to the clk-ddr in rockchip to not use the cached
rate for get_rate. This is to handle timeout error conditions in SMC
for the set rate function.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/clk/rockchip/clk-ddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index de00590af167..dffd5ac5847b 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -226,7 +226,7 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 	init.num_parents = num_parents;
 
 	init.flags = flags;
-	init.flags |= CLK_SET_RATE_NO_REPARENT;
+	init.flags |= CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE;
 
 	switch (ddr_flag) {
 	case ROCKCHIP_DDRCLK_SIP:
-- 
2.17.0
