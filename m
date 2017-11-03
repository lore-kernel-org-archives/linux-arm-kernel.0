From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri,  3 Nov 2017 11:57:47 +0100
Subject: [PATCH] clk: sunxi-ng: a83t: Fix i2c buses bits
Message-ID: <20171103105747.26335-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c1 and i2c2 bits for CCU are not bit 0 but bit 1 and bit 2.
Because of that, the i2c0 (bit 0) was not correctly configured.
Fixed the correct bits for i2c1 and i2c2.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index e43acebdfbcd..f8203115a6bc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -354,9 +354,9 @@ static SUNXI_CCU_GATE(bus_tdm_clk,	"bus-tdm",	"apb1",
 static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
 		      0x06c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_i2c1_clk,	"bus-i2c1",	"apb2",
-		      0x06c, BIT(0), 0);
+		      0x06c, BIT(1), 0);
 static SUNXI_CCU_GATE(bus_i2c2_clk,	"bus-i2c2",	"apb2",
-		      0x06c, BIT(0), 0);
+		      0x06c, BIT(2), 0);
 static SUNXI_CCU_GATE(bus_uart0_clk,	"bus-uart0",	"apb2",
 		      0x06c, BIT(16), 0);
 static SUNXI_CCU_GATE(bus_uart1_clk,	"bus-uart1",	"apb2",
-- 
2.11.0
