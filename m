From: tommyhebb@gmail.com (Thomas Hebb)
Date: Thu, 2 Jul 2015 01:04:18 -0400
Subject: [PATCH 1/4] phy: berlin-usb: fix divider for BG2CD
Message-ID: <5594C652.2020901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The marvell,berlin2cd-usb-phy compatible incorrectly sets the PLL
divider to BG2's value instead of BG2CD/BG2Q's. Change it to the right
value.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Cc: stable at vger.kernel.org
---
 drivers/phy/phy-berlin-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
index c6fc95b..ab54f28 100644
--- a/drivers/phy/phy-berlin-usb.c
+++ b/drivers/phy/phy-berlin-usb.c
@@ -106,8 +106,8 @@
 static const u32 phy_berlin_pll_dividers[] = {
 	/* Berlin 2 */
 	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
-	/* Berlin 2CD */
-	CLK_REF_DIV(0x6) | FEEDBACK_CLK_DIV(0x55),
+	/* Berlin 2CD/Q */
+	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
 };
 
 struct phy_berlin_usb_priv {
-- 
2.4.4
