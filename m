From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Sun, 12 Jun 2011 17:04:57 +0200
Subject: [PATCH v2 2/5] ARM: ep93xx: add model detection for ts-7300 and
	ts-7400 boards
In-Reply-To: <1307891100-31123-1-git-send-email-ynezz@true.cz>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
Message-ID: <1307891100-31123-3-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Ryan Mallon <ryan@bluewatersys.com>
Acked-By: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index 0eabec6..ee7f875 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -20,6 +20,8 @@
 #define TS72XX_MODEL_TS7200		0x00
 #define TS72XX_MODEL_TS7250		0x01
 #define TS72XX_MODEL_TS7260		0x02
+#define TS72XX_MODEL_TS7300		0x03
+#define TS72XX_MODEL_TS7400		0x04
 
 
 #define TS72XX_OPTIONS_PHYS_BASE	0x22400000
@@ -66,6 +68,16 @@ static inline int board_is_ts7260(void)
 	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7260;
 }
 
+static inline int board_is_ts7300(void)
+{
+	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7300;
+}
+
+static inline int board_is_ts7400(void)
+{
+	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7400;
+}
+
 static inline int is_max197_installed(void)
 {
 	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE) &
-- 
1.7.1
