From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:14 +0400
Subject: [PATCH 01/17] ARM clps711x: Cleanup: Rename ARCH_EP7211 and
 ARCH_EP7212 to SOC_xxx
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In fact, these definitions indicate the CPU variant, so it is logically
correct to change the name of the definitions.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig                 |    8 ++++----
 arch/arm/mach-clps711x/include/mach/hardware.h |    4 ++--
 drivers/net/irda/Kconfig                       |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index eb34bd1..ec47ef4 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -47,24 +47,24 @@ config ARCH_FORTUNET
 
 # XXX Maybe these should indicate register compatibility
 # instead of being mutually exclusive.
-config ARCH_EP7211
+config SOC_EP7211
 	bool
 	depends on ARCH_EDB7211
 	default y
 
-config ARCH_EP7212
+config SOC_EP7212
 	bool
 	depends on ARCH_P720T || ARCH_CEIVA
 	default y
 
 config EP72XX_ROM_BOOT
 	bool "EP72xx ROM boot"
-	depends on ARCH_EP7211 || ARCH_EP7212
+	depends on SOC_EP7211 || SOC_EP7212
 	---help---
 	  If you say Y here, your CLPS711x-based kernel will use the bootstrap
 	  mode memory map instead of the normal memory map.
 
-	  Processors derived from the Cirrus CLPS-711X core support two boot
+	  Processors derived from the Cirrus CLPS711X core support two boot
 	  modes.  Normal mode boots from the external memory device at CS0.
 	  Bootstrap mode rearranges parts of the memory map, placing an
 	  internal 128 byte bootstrap ROM at CS0.  This option performs the
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index d0b7d87..99461f3 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -52,13 +52,13 @@
 #define CS7_PHYS_BASE		(0x00000000)
 #endif
 
-#if defined (CONFIG_ARCH_EP7211)
+#if defined (CONFIG_SOC_EP7211)
 
 #define EP7211_VIRT_BASE	CLPS7111_VIRT_BASE
 #define EP7211_BASE		CLPS7111_VIRT_BASE
 #include <asm/hardware/ep7211.h>
 
-#elif defined (CONFIG_ARCH_EP7212)
+#elif defined (CONFIG_SOC_EP7212)
 
 #define EP7212_VIRT_BASE	CLPS7111_VIRT_BASE
 #define EP7212_BASE		CLPS7111_VIRT_BASE
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 4680478..54d7723 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -212,7 +212,7 @@ config KINGSUN_DONGLE
 
 config EP7211_DONGLE
 	tristate "EP7211 I/R support"
-	depends on IRTTY_SIR && ARCH_EP7211 && IRDA && EXPERIMENTAL
+	depends on IRTTY_SIR && (SOC_EP7211 || SOC_EP7212) && IRDA && EXPERIMENTAL
 	help
 	  Say Y here if you want to build support for the Cirrus logic
 	  EP7211 chipset's infrared module.
-- 
1.7.3.4
