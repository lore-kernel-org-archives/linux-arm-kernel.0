From: triad@df.lth.se (Linus Walleij)
Date: Thu, 22 Jul 2010 22:40:57 +0200
Subject: [PATCH] ARM: fix Versatile Express LED oversight
Message-ID: <1279831257-28738-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My attempt to make the LEDs only compile for RealView and
Versatile was futile: I missed the Versatile Express. So invert
the logic and explicitly include the platforms to compile for.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
 arch/arm/plat-versatile/Makefile |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 505a8f8..5cf88e8 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,7 +1,8 @@
 obj-y	:= clock.o
 obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
-# For all but the Integrator, compile these
-ifeq ($(CONFIG_ARCH_INTEGRATOR),)
-obj-y += sched-clock.o
-obj-$(CONFIG_LEDS_CLASS) += leds.o
+obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
+obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
+ifeq ($(CONFIG_LEDS_CLASS),y)
+obj-$(CONFIG_ARCH_REALVIEW) += leds.o
+obj-$(CONFIG_ARCH_VERSATILE) += leds.o
 endif
-- 
1.7.1.1
