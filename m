From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 Jan 2011 11:34:06 +0000
Subject: [PATCH 2.6.38 2/3] ARM: SMDK6410: Fix build with WM1190 disabled and
	WM1192 enabled
In-Reply-To: <1296473647-8094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1296473647-8094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1296473647-8094-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid relying on implicit inclusion of machine.h

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 9fea1c2..df9b76b 100644
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
