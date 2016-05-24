From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 24 May 2016 13:41:01 -0400
Subject: [PATCH 1/2] clk: exynos5420: Set ID for aclk333 gate clock
In-Reply-To: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
References: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1464111662-15336-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aclk333 clock needs to be ungated during the MFC power domain switch,
so set the clock ID to allow the Exynos power domain logic to lookup this
clock if is defined in the MFC PD device tree node.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 92382cef9f90..469bcae5de3a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -946,7 +946,7 @@ static struct samsung_gate_clock exynos5x_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 13, 0, 0),
 	GATE(0, "aclk166", "mout_user_aclk166",
 			GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk333", "mout_user_aclk333",
+	GATE(CLK_ACLK333, "aclk333", "mout_user_aclk333",
 			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
 			GATE_BUS_TOP, 16, 0, 0),
-- 
2.5.5
