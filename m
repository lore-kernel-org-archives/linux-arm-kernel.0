From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Sep 2011 20:07:19 +0800
Subject: [PATCH] arm/mx5: remove the magic reference to '__NA_' from
	board-mx51_efikasb.c
Message-ID: <1317384439-24519-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is to fix the compile error below.

  CC      arch/arm/mach-mx5/board-mx51_efikasb.o
arch/arm/mach-mx5/board-mx51_efikasb.c:102:2: error: ?__NA_? undeclared here (not in a function)
make[2]: *** [arch/arm/mach-mx5/board-mx51_efikasb.o] Error 1

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Sascha,

This is a compile error seen on your imx-features branch.

 arch/arm/mach-mx5/board-mx51_efikasb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index b491513..46eac80 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -56,7 +56,7 @@
 #define EFIKASB_RFKILL		IMX_GPIO_NR(3, 1)
 
 #define MX51_PAD_PWRKEY IOMUX_PAD(0x48c, 0x0f8, 1, 0x0,   0, PAD_CTL_PUS_100K_UP | PAD_CTL_PKE)
-#define MX51_PAD_SD1_CD	IOMUX_PAD(0x47c, 0x0e8, 1, __NA_, 0, MX51_ESDHC_PAD_CTRL)
+#define MX51_PAD_SD1_CD	IOMUX_PAD(0x47c, 0x0e8, 1, 0x0, 0, MX51_ESDHC_PAD_CTRL)
 
 static iomux_v3_cfg_t mx51efikasb_pads[] = {
 	/* USB HOST2 */
-- 
1.7.4.1
