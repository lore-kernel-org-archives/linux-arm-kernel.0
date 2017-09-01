From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  1 Sep 2017 10:01:46 +0800
Subject: [PATCH v1 3/3] clk: rockchip: rk3126: add sclk_timer5 as critical
 clock
In-Reply-To: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
References: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1504231306-4450-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sclk_timer5 is for arm arch counter, so need always on.
but no dts node to handle this clk, so make it as critical clock

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index ce02d2cff608..5970a50671b9 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -578,6 +578,7 @@ enum rk3128_plls {
 	"hclk_peri",
 	"pclk_peri",
 	"pclk_pmu",
+	"sclk_timer5",
 };
 
 static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np)
-- 
1.9.1
