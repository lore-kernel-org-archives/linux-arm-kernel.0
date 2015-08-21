From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 21 Aug 2015 18:10:27 +0000
Subject: [PATCH] clk: rockchip: Add pclk_peri to critical clocks on
 RK3066/RK3188
Message-ID: <1440180627-4566-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks for bank GPIO3 and GPIO4 are supplied by pclk_peri. These clocks need to
stay on, otherwise pinctrl hangs the system when the driver is probed.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index f63a642..596be81 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -717,6 +717,7 @@ static const char *const rk3188_critical_clocks[] __initconst = {
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_cpu",
+	"pclk_peri",
 };
 
 static void __init rk3188_common_clk_init(struct device_node *np)
-- 
2.1.4
