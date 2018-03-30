From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 18:44:44 +0900
Subject: [PATCH 2/2] reset: uniphier: add SATA reset control support and
 change SATA-PHY ID
In-Reply-To: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset lines for SATA controller on UniPhier SoCs.
This adds support for Pro4 and PXs3 in addition to PXs2.

And this changes the ID of the reset line for SATA-PHY on PXs2.
Since some SoCs have two controller instances with a common PHY, this moves
the ID of SATA-PHY for consistency.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 55ae0f1..90e6caf 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -63,6 +63,9 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (Ether, SATA, USB3) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
 	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
+	UNIPHIER_RESETX(28, 0x2000, 18),	/* SATA0 */
+	UNIPHIER_RESETX(29, 0x2004, 18),	/* SATA1 */
+	UNIPHIER_RESETX(30, 0x2000, 19),	/* SATA-PHY */
 	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
@@ -90,7 +93,7 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_RESETX(20, 0x2014, 5),		/* USB31-PHY0 */
 	UNIPHIER_RESETX(21, 0x2014, 1),		/* USB31-PHY1 */
 	UNIPHIER_RESETX(28, 0x2014, 12),	/* SATA */
-	UNIPHIER_RESET(29, 0x2014, 8),		/* SATA-PHY (active high) */
+	UNIPHIER_RESET(30, 0x2014, 8),		/* SATA-PHY (active high) */
 	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
@@ -137,6 +140,9 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
 	UNIPHIER_RESETX(20, 0x200c, 17),	/* USB31-PHY0 */
 	UNIPHIER_RESETX(21, 0x200c, 19),	/* USB31-PHY1 */
 	UNIPHIER_RESETX(24, 0x200c, 3),		/* PCIe */
+	UNIPHIER_RESETX(28, 0x200c, 7),		/* SATA0 */
+	UNIPHIER_RESETX(29, 0x200c, 8),		/* SATA1 */
+	UNIPHIER_RESETX(30, 0x200c, 21),	/* SATA-PHY */
 	UNIPHIER_RESET_END,
 };
 
-- 
2.7.4
