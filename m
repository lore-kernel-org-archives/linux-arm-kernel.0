From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Sun, 13 Aug 2017 18:00:41 +0900
Subject: [PATCH v2 1/3] reset: uniphier: add audio systems reset control
Message-ID: <20170813090043.3828-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset lines for audio subsystem (AIO) and
SoC internal audio codec (EVEA) on UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/reset/reset-uniphier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 954b2c4e6ca7..90c52a96f775 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -93,6 +93,8 @@ static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC, MIO) */
+	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
+	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
 	UNIPHIER_RESET_END,
 };
 
@@ -105,6 +107,8 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
 	UNIPHIER_RESETX(19, 0x200c, 15),	/* USB30-PHY3 */
+	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
+	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
 	UNIPHIER_RESET_END,
 };
 
-- 
2.13.2
