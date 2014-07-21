From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 13:38:11 +0800
Subject: [PATCH] ARM: i.MX6: add more chip revision support
Message-ID: <1405921091-28748-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Liu <r64343@freescale.com>

Add more revision support for the new i.MX6DQ tap-out (TO1.5).  This
TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
and TO1.4 are never revealed.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/anatop.c | 9 +++++++++
 arch/arm/mach-imx/mxc.h    | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 4a40bbb46183..459ba290744b 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -104,6 +104,15 @@ void __init imx_init_revision_from_anatop(void)
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
