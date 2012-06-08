From: axel.lin@gmail.com (Axel Lin)
Date: Sat, 09 Jun 2012 07:48:02 +0800
Subject: [PATCH] ARM: plat-versatile: Make PLAT_VERSATILE_LEDS depend on
 LEDS_CLASS=y
Message-ID: <1339199282.15067.3.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

config PLAT_VERSATILE_LEDS needs LEDS_CLASS=y, otherwise I got below build
error when CONFIG_LEDS_CLASS=m.

  LD      init/built-in.o
arch/arm/plat-versatile/built-in.o: In function `versatile_leds_init':
sched-clock.c:(.init.text+0x190): undefined reference to `led_classdev_register'
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/plat-versatile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 81ee7cc..62ffdc7 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -13,7 +13,7 @@ config PLAT_VERSATILE_FPGA_IRQ_NR
        depends on PLAT_VERSATILE_FPGA_IRQ
 
 config PLAT_VERSATILE_LEDS
-	def_bool y if LEDS_CLASS
+	def_bool y if LEDS_CLASS=y
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
 
 config PLAT_VERSATILE_SCHED_CLOCK
-- 
1.7.9.5
