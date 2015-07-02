From: tommyhebb@gmail.com (Thomas Hebb)
Date: Thu, 2 Jul 2015 01:04:26 -0400
Subject: [PATCH 3/4] phy: berlin-usb: fix divider for BG2
Message-ID: <5594C65A.8060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PLL divider set by the marvell,berlin2-usb-phy compatible is not
correct for BG2. We couldn't change it before because BG2Q incorrectly
used the same compatible string. Now that BG2Q's compatible is fixed,
change BG2's divider to the correct value.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 drivers/phy/phy-berlin-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
index ab54f28..335e06d 100644
--- a/drivers/phy/phy-berlin-usb.c
+++ b/drivers/phy/phy-berlin-usb.c
@@ -105,7 +105,7 @@
 
 static const u32 phy_berlin_pll_dividers[] = {
 	/* Berlin 2 */
-	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
+	CLK_REF_DIV(0x6) | FEEDBACK_CLK_DIV(0x55),
 	/* Berlin 2CD/Q */
 	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
 };
-- 
2.4.4
