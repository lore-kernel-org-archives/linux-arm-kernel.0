From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 10 Aug 2018 23:16:38 +0800
Subject: [PATCH] clk: sunxi-ng: h6: fix PWM gate/reset offset
Message-ID: <20180810151638.30900-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongyi Chen <chenyi@tt-cool.com>

Currently the register offset of the PWM bus gate in Allwinner H6 clock
driver is wrong.

Fix this issue.

Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Rongyi Chen <chenyi@tt-cool.com>
[Icenowy: refactor commit message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index bdbfe78fe133..8eea58f9298c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -352,7 +352,7 @@ static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
 static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
 		      0x79c, BIT(0), 0);
 
-static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x79c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
 
 static SUNXI_CCU_GATE(bus_iommu_clk, "bus-iommu", "apb1", 0x7bc, BIT(0), 0);
 
-- 
2.18.0
