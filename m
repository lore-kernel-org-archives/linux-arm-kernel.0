From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  8 Dec 2011 15:07:18 +0800
Subject: [PATCH 1/2] ARM: pxa: fix build error for GPIO_bit()
Message-ID: <1323328039-9603-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-pxa/spitz_pm.c: In function ?spitz_presuspend?:
arch/arm/mach-pxa/spitz_pm.c:112:2: error: implicit declaration of
function ?GPIO_bit?
make[1]: *** [arch/arm/mach-pxa/spitz_pm.o] Error 1

GPIO_bit() is moved into <linux/gpio-pxa.h>.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/spitz_pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 5cc05d1..34cbdac 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
-- 
1.7.0.4
