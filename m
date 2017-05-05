From: iemdey@gmail.com (Yong Deng)
Date: Fri,  5 May 2017 18:31:57 +0800
Subject: [PATCH v2] clk: sunxi-ng: v3s: Fix usb otg device reset bit
Message-ID: <1493980317-39775-1-git-send-email-iemdey@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3S's usb otg device reset bit should be 24, not 23.

Signed-off-by: Yong Deng <iemdey@gmail.com>
Reviewed-By: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Fix commit format

 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index e58706b..6297add 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -537,7 +537,7 @@ static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
 	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
 	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
 	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
-	[RST_BUS_OTG]		=  { 0x2c0, BIT(23) },
+	[RST_BUS_OTG]		=  { 0x2c0, BIT(24) },
 	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(26) },
 	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
 
-- 
1.8.3.1
