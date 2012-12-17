From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:11:08 +0000
Subject: [PATCH] ARM: realview: fix private peripheral memory base for EB rev.
 B boards
Message-ID: <1355760668-28606-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 34ae6c96a6a7 ("ARM: 7298/1: realview: fix mapping of MPCore
private memory region") accidentally broke the definition for the base
address of the private peripheral region on revision B Realview-EB
boards.

This patch uses the correct address for REALVIEW_EB11MP_PRIV_MEM_BASE.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/include/mach/board-eb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-realview/include/mach/board-eb.h b/arch/arm/mach-realview/include/mach/board-eb.h
index 124bce6..a301e61 100644
--- a/arch/arm/mach-realview/include/mach/board-eb.h
+++ b/arch/arm/mach-realview/include/mach/board-eb.h
@@ -47,7 +47,7 @@
 #define REALVIEW_EB_USB_BASE		0x4F000000	/* USB */
 
 #ifdef CONFIG_REALVIEW_EB_ARM11MP_REVB
-#define REALVIEW_EB11MP_PRIV_MEM_BASE	0x1F000000
+#define REALVIEW_EB11MP_PRIV_MEM_BASE	0x10100000
 #define REALVIEW_EB11MP_L220_BASE	0x10102000	/* L220 registers */
 #define REALVIEW_EB11MP_SYS_PLD_CTRL1	0xD8		/* Register offset for MPCore sysctl */
 #else
-- 
1.8.0
