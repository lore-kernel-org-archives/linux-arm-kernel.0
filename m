From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  2 May 2017 15:34:03 +0800
Subject: [PATCH v3 1/4] clk: rockchip: rk3036: make pclk_ddrupctl as
 critical_clock
In-Reply-To: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
References: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1493710446-7203-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No driver to handle this clk, Chip design requirements for this clock to always on,
The new document will update the description of this clock.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3036.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 924f560dcf80..e97bee585b2f 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -436,6 +436,7 @@ enum rk3036_plls {
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_peri",
+	"pclk_ddrupctl",
 };
 
 static void __init rk3036_clk_init(struct device_node *np)
-- 
1.9.1
