From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:30 +0400
Subject: [PATCH 17/17] ARM clps711x: Make select CPU spees as KConfig option
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-18-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig                 |    4 ++++
 arch/arm/mach-clps711x/include/mach/hardware.h |    3 +--
 arch/arm/mach-clps711x/include/mach/timex.h    |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 28ac4d6..aeb7ec2 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -61,6 +61,10 @@ config ARCH_FORTUNET
 	bool "FORTUNET"
 	select SOC_EP7312
 
+config EP72XX_CPU_SPEED
+	int "CPU frequency"
+	default 73728000
+
 config EP72XX_ROM_BOOT
 	bool "EP72xx ROM boot"
 	depends on SOC_EP7211 || SOC_EP7212 || SOC_EP7312
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index acaf777..b234922 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -24,8 +24,7 @@
 
 #include <asm/hardware/clps7111.h>
 
-#define CPU_SPEED		(73728000)
-#define CPU_BUS_SPEED		(CPU_SPEED / 2)
+#define CPU_BUS_SPEED		(CONFIG_EP72XX_CPU_SPEED / 2)
 #define UART_BAUD_BASE		(CPU_BUS_SPEED / 10)
 
 #define CLPS711X_PHYS_BASE	(0x80000000)
diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
index 56f5ecf..d558e71 100644
--- a/arch/arm/mach-clps711x/include/mach/timex.h
+++ b/arch/arm/mach-clps711x/include/mach/timex.h
@@ -22,4 +22,4 @@
 
 #include <mach/hardware.h>
 
-#define CLOCK_TICK_RATE	(CPU_SPEED / 144)
+#define CLOCK_TICK_RATE	(CONFIG_EP72XX_CPU_SPEED / 144)
-- 
1.7.3.4
