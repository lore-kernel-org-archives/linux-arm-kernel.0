From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Fri, 26 Aug 2016 13:24:13 +0200
Subject: [PATCH] clk: sunxi-ng: Fix wrong reset register offsets
Message-ID: <1472210653-32170-1-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

The reset register offsets for UART*, I2C* and SCR were off by a few bytes.
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index feabc0f..280ba74 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -783,14 +783,14 @@ static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
 	[RST_BUS_I2S1]		=  { 0x2d0, BIT(13) },
 	[RST_BUS_I2S2]		=  { 0x2d0, BIT(14) },
 
-	[RST_BUS_I2C0]		=  { 0x2d4, BIT(0) },
-	[RST_BUS_I2C1]		=  { 0x2d4, BIT(1) },
-	[RST_BUS_I2C2]		=  { 0x2d4, BIT(2) },
-	[RST_BUS_UART0]		=  { 0x2d4, BIT(16) },
-	[RST_BUS_UART1]		=  { 0x2d4, BIT(17) },
-	[RST_BUS_UART2]		=  { 0x2d4, BIT(18) },
-	[RST_BUS_UART3]		=  { 0x2d4, BIT(19) },
-	[RST_BUS_SCR]		=  { 0x2d4, BIT(20) },
+	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
+	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
+	[RST_BUS_I2C2]		=  { 0x2d8, BIT(2) },
+	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
+	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
+	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
+	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
+	[RST_BUS_SCR]		=  { 0x2d8, BIT(20) },
 };
 
 static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
-- 
2.7.4
