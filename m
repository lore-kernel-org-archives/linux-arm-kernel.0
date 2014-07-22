From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 12:32:54 +0800
Subject: [PATCH v2] ARM: i.MX6: add more chip revision support
Message-ID: <1406003574-4977-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Liu <r64343@freescale.com>

Add more revision support for the new i.MX6DQ tape-out (TO1.5).  This
TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
and TO1.4 are never revealed.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes since v1:
 - Add a note in code for the numbering mismatch between code and
   data sheet
 - Fix a typo of tape-out in commit log

 arch/arm/mach-imx/anatop.c | 13 +++++++++++++
 arch/arm/mach-imx/mxc.h    |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 4a40bbb46183..8259a625a920 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -104,6 +104,19 @@ void __init imx_init_revision_from_anatop(void)
 	case 2:
 		revision = IMX_CHIP_REVISION_1_2;
 		break;
+	case 3:
+		revision = IMX_CHIP_REVISION_1_3;
+		break;
+	case 4:
+		revision = IMX_CHIP_REVISION_1_4;
+		break;
+	case 5:
+		/*
+		 * i.MX6DQ TO1.5 is defined as Rev 1.3 in Data Sheet, marked
+		 * as 'D' in Part Number last character.
+		 */
+		revision = IMX_CHIP_REVISION_1_5;
+		break;
 	default:
 		revision = IMX_CHIP_REVISION_UNKNOWN;
 	}
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index a39b69ef4301..17a41ca65acf 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -43,6 +43,8 @@
 #define IMX_CHIP_REVISION_1_1		0x11
 #define IMX_CHIP_REVISION_1_2		0x12
 #define IMX_CHIP_REVISION_1_3		0x13
+#define IMX_CHIP_REVISION_1_4		0x14
+#define IMX_CHIP_REVISION_1_5		0x15
 #define IMX_CHIP_REVISION_2_0		0x20
 #define IMX_CHIP_REVISION_2_1		0x21
 #define IMX_CHIP_REVISION_2_2		0x22
-- 
1.9.1
