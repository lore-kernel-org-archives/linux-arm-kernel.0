From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 28 Aug 2017 18:59:38 +0900
Subject: [PATCH] reset: uniphier: add ethernet reset control support
Message-ID: <1503914378-24615-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset lines for ethernet controller on Pro4, PXs2, LD11 and
LD20 SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index bda2dd1..6e40f7d 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -58,6 +58,7 @@ static const struct uniphier_reset_data uniphier_ld4_sys_reset_data[] = {
 
 static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(6, 0x2000, 12),		/* Ether */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, MIO, RLE) */
 	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (Ether, SATA, USB3) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
@@ -76,6 +77,7 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 
 static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x2000, 2),		/* NAND */
+	UNIPHIER_RESETX(6, 0x2000, 12),		/* Ether */
 	UNIPHIER_RESETX(8, 0x2000, 10),		/* STDMAC (HSC, RLE) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
 	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
@@ -92,6 +94,7 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
+	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC, MIO) */
 	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
 	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
@@ -102,6 +105,7 @@ static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
+	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC) */
 	UNIPHIER_RESETX(12, 0x200c, 5),		/* GIO (PCIe, USB3) */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
-- 
2.7.4
