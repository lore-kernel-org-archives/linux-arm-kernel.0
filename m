From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 21 Jan 2011 17:27:09 +0000
Subject: [PATCH] ARM: SMDK6410: Fix build with WM1190 disabled and WM1192
	enabled
Message-ID: <1295630829-13812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid relying on implicit inclusion of machine.h

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: stable at kernel.org
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index c8a84be..e7b40ba 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/smsc911x.h>
 #include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
-- 
1.7.2.3
