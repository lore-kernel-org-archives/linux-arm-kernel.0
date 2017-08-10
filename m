From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 10 Aug 2017 16:27:02 +0900
Subject: [PATCH 2/3] reset: uniphier: add video input subsystem reset control
In-Reply-To: <20170810072703.32433-1-suzuki.katsuhiro@socionext.com>
References: <20170810072703.32433-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20170810072703.32433-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a reset line for video input subsystem (EXIV) on
UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/reset/reset-uniphier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 90c52a96f775..f60c137c17cb 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -95,6 +95,7 @@ static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC, MIO) */
 	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
 	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
+	UNIPHIER_RESETX(42, 0x2010, 2),		/* EXIV */
 	UNIPHIER_RESET_END,
 };
 
@@ -109,6 +110,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(19, 0x200c, 15),	/* USB30-PHY3 */
 	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
 	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
+	UNIPHIER_RESETX(42, 0x2010, 2),		/* EXIV */
 	UNIPHIER_RESET_END,
 };
 
-- 
2.13.2
