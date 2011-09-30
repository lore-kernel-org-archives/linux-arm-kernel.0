From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Sep 2011 20:05:55 +0800
Subject: [PATCH] arm/imx: rename MX51_MXC_INT_ATA to MX51_INT_ATA
Message-ID: <1317384355-24481-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is to fix the compile error below.

  CC      arch/arm/plat-mxc/devices/platform-pata_imx.o
arch/arm/plat-mxc/devices/platform-pata_imx.c:33:1: error: ?MX51_INT_ATA? undeclared here (not in a function)
make[3]: *** [arch/arm/plat-mxc/devices/platform-pata_imx.o] Error 1

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Sascha,

This is a compile error seen on your imx-features branch.

 arch/arm/plat-mxc/include/mach/mx51.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index dede19a..0d4aa9e 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -311,7 +311,7 @@
 #define MX51_MXC_INT_SIM_IPB		67
 #define MX51_MXC_INT_SIM_DAT		68
 #define MX51_MXC_INT_IIM		69
-#define MX51_MXC_INT_ATA		70
+#define MX51_INT_ATA			70
 #define MX51_MXC_INT_CCM1		71
 #define MX51_MXC_INT_CCM2		72
 #define MX51_MXC_INT_GPC1		73
-- 
1.7.4.1
