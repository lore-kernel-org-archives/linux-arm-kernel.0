From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Jun 2011 22:41:15 +0530
Subject: [PATCH 1/3] davinci: dm646x.h: include header files under mach/ after
	those in linux/
Message-ID: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general header file inclusion order followed
in the kernel is to include files under linux/
first and then under mach/.

The dm646x.h file has the opposite of this. Fix it.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/include/mach/dm646x.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 7a27f3f..5e95b02 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -11,13 +11,14 @@
 #ifndef __ASM_ARCH_DM646X_H
 #define __ASM_ARCH_DM646X_H
 
-#include <mach/hardware.h>
-#include <mach/asp.h>
 #include <linux/i2c.h>
 #include <linux/videodev2.h>
 #include <linux/clk.h>
 #include <linux/davinci_emac.h>
 
+#include <mach/hardware.h>
+#include <mach/asp.h>
+
 #define DM646X_EMAC_BASE		(0x01C80000)
 #define DM646X_EMAC_MDIO_BASE		(DM646X_EMAC_BASE + 0x4000)
 #define DM646X_EMAC_CNTRL_OFFSET	(0x0000)
-- 
1.7.3.2
