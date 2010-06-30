From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:01:39 +0200
Subject: [PATCH 24/33] Removing dead ARCH_GUMSTIX_ORIG
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <e2a294ec1d41f1198f7ffae0e8bed2f67b41bbe8.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_GUMSTIX_ORIG doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-pxa/include/mach/gumstix.h |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/include/mach/gumstix.h
index 06abd41..9b89868 100644
--- a/arch/arm/mach-pxa/include/mach/gumstix.h
+++ b/arch/arm/mach-pxa/include/mach/gumstix.h
@@ -14,25 +14,15 @@
 
 /*
 GPIOn - Input from MAX823 (or equiv), normalizing USB +5V into a clean
-interrupt signal for determining cable presence. On the original gumstix,
-this is GPIO81, and GPIO83 needs to be defined as well. On the gumstix F,
+interrupt signal for determining cable presence. On the gumstix F,
 this moves to GPIO17 and GPIO37. */
 
 /* GPIOx - Connects to USB D+ and used as a pull-up after GPIOn
 has detected a cable insertion; driven low otherwise. */
 
-#ifdef CONFIG_ARCH_GUMSTIX_ORIG
-
-#define GPIO_GUMSTIX_USB_GPIOn		81
-#define GPIO_GUMSTIX_USB_GPIOx		83
-
-#else
-
 #define GPIO_GUMSTIX_USB_GPIOn		35
 #define GPIO_GUMSTIX_USB_GPIOx		41
 
-#endif
-
 /* usb state change */
 #define GUMSTIX_USB_INTR_IRQ		IRQ_GPIO(GPIO_GUMSTIX_USB_GPIOn)
 
-- 
1.7.0.4
