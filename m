From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  8 Dec 2011 15:07:19 +0800
Subject: [PATCH 2/2] ARM: pxa: fix the build error because of missing
 gpio-pxa.h
In-Reply-To: <1323328039-9603-1-git-send-email-haojian.zhuang@marvell.com>
References: <1323328039-9603-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1323328039-9603-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-pxa/corgi_pm.c: In function ?corgi_should_wakeup?:
arch/arm/mach-pxa/corgi_pm.c:102:2: error: implicit declaration of
function ?GPIO_bit?
make[1]: *** [arch/arm/mach-pxa/corgi_pm.o] Error 1
make: *** [arch/arm/mach-pxa] Error 2

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/corgi_pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index eca862f..39e265c 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
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
