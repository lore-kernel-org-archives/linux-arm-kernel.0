From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Tue, 09 Jan 2018 13:51:13 +0100
Subject: [PATCH] ARM: i.MX6: add new silicon revision number 1.6
Message-ID: <1515502273.2493.9.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new silicon revision number 1.6 as specified in document
IMX6DQCEC.pdf.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/mach-imx/anatop.c | 4 ++++
 include/soc/imx/revision.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 649a84c..deb98b8 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -157,6 +157,10 @@ void __init imx_init_revision_from_anatop(void)
 		 */
 		revision = IMX_CHIP_REVISION_1_5;
 		break;
+	case 6:
+		/* marked as 'E' in part number last character */
+		revision = IMX_CHIP_REVISION_1_6;
+		break;
 	default:
 		/*
 		 * Fail back to return raw register value instead of 0xff.
diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
index 9ea3469..cd4c847 100644
--- a/include/soc/imx/revision.h
+++ b/include/soc/imx/revision.h
@@ -15,6 +15,7 @@
 #define IMX_CHIP_REVISION_1_3		0x13
 #define IMX_CHIP_REVISION_1_4		0x14
 #define IMX_CHIP_REVISION_1_5		0x15
+#define IMX_CHIP_REVISION_1_6		0x16
 #define IMX_CHIP_REVISION_2_0		0x20
 #define IMX_CHIP_REVISION_2_1		0x21
 #define IMX_CHIP_REVISION_2_2		0x22
-- 
2.1.4
