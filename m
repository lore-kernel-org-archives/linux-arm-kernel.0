From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 02 Oct 2011 18:25:30 +0900
Subject: [PATCH] ARM: EXYNOS: Add ARCH_EXYNOS and reorganize
	arch/arm/mach-exynos
Message-ID: <001f01cc80e5$3abd1c80$b0375580$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm/mach-exynos4 directory (CONFIG_ARCH_EXYNOS4) has
made for plaforms based on EXYNOS4 SoCs. But since upcoming
Samsung's SoCs such as EXYNOS5 (ARM Cortex A15) can reuse most
codes in current mach-exynos4, one mach-exynos directory will
be used for them.

This patch changes to CONFIG_ARCH_EXYNOS (arch/arm/mach-exynos)
but keeps original CONFIG_ARCH_EXYNOS4 in mach-exynos/Kconfig to
avoid changing in driver side.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE: The codes for upcoming SoCs will be implemented soon.

 arch/arm/Kconfig                                   |    8 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/configs/exynos4_defconfig                 |    7 +--
 arch/arm/{mach-exynos4 => mach-exynos}/Kconfig     |   41 +++++++++---
 arch/arm/{mach-exynos4 => mach-exynos}/Makefile    |    8 +-
 .../{mach-exynos4 => mach-exynos}/Makefile.boot    |    0
 .../clock-exynos4210.c                             |    0
 .../clock-exynos4212.c                             |    0
 arch/arm/{mach-exynos4 => mach-exynos}/clock.c     |    0
 arch/arm/{mach-exynos4 => mach-exynos}/cpu.c       |   69 +++++++++++---------
 arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c  |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c    |    0
 .../arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dma.c       |    0
 arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c   |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/dma.h                             |    0
 .../include/mach/dwmci.h                           |    0
 .../include/mach/entry-macro.S                     |    0
 .../include/mach/exynos4-clock.h                   |    0
 .../include/mach/gpio.h                            |    0
 .../include/mach/hardware.h                        |    0
 .../include/mach/io.h                              |    0
 .../include/mach/irqs.h                            |    0
 .../include/mach/map.h                             |   32 ++++++----
 .../include/mach/memory.h                          |    0
 .../include/mach/pm-core.h                         |    0
 .../include/mach/pmu.h                             |    0
 .../include/mach/regs-audss.h                      |    0
 .../include/mach/regs-clock.h                      |    0
 .../include/mach/regs-gpio.h                       |    0
 .../include/mach/regs-irq.h                        |    0
 .../include/mach/regs-mct.h                        |    0
 .../include/mach/regs-mem.h                        |    0
 .../include/mach/regs-pmu.h                        |    0
 .../include/mach/regs-sysmmu.h                     |    0
 .../include/mach/regs-usb-phy.h                    |    0
 .../include/mach/sysmmu.h                          |    0
 .../include/mach/system.h                          |    0
 .../include/mach/timex.h                           |    0
 .../include/mach/uncompress.h                      |    0
 .../include/mach/vmalloc.h                         |    0
 arch/arm/{mach-exynos4 => mach-exynos}/init.c      |    0
 .../{mach-exynos4 => mach-exynos}/irq-combiner.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c  |    0
 .../mach-armlex4210.c                              |    0
 arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c |    0
 .../{mach-exynos4 => mach-exynos}/mach-origen.c    |    0
 .../{mach-exynos4 => mach-exynos}/mach-smdk4x12.c  |    0
 .../{mach-exynos4 => mach-exynos}/mach-smdkv310.c  |    0
 .../mach-universal_c210.c                          |    0
 arch/arm/{mach-exynos4 => mach-exynos}/mct.c       |    0
 arch/arm/{mach-exynos4 => mach-exynos}/platsmp.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/pm.c        |    0
 arch/arm/{mach-exynos4 => mach-exynos}/pmu.c       |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-fimc.c |    0
 .../{mach-exynos4 => mach-exynos}/setup-fimd0.c    |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c0.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c1.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c2.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c3.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c4.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c5.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c6.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c7.c |    0
 .../{mach-exynos4 => mach-exynos}/setup-keypad.c   |    0
 .../setup-sdhci-gpio.c                             |    0
 .../{mach-exynos4 => mach-exynos}/setup-sdhci.c    |    0
 .../{mach-exynos4 => mach-exynos}/setup-usb-phy.c  |    0
 arch/arm/{mach-exynos4 => mach-exynos}/sleep.S     |    0
 arch/arm/plat-s5p/Kconfig                          |    2 +-
 arch/arm/plat-s5p/cpu.c                            |    6 +-
 arch/arm/plat-samsung/include/plat/exynos4.h       |    6 +-
 77 files changed, 104 insertions(+), 77 deletions(-)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Kconfig (91%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile (89%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile.boot (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4212.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpu.c (91%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dma.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/debug-macro.S (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dma.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dwmci.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/entry-macro.S (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/exynos4-clock.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/io.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/map.h (93%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/memory.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/pm-core.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/pmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-audss.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-clock.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-gpio.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-irq.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-mct.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-mem.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-pmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-sysmmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-usb-phy.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/sysmmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/system.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/timex.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/uncompress.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/vmalloc.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/init.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-combiner.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-armlex4210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-origen.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-smdk4x12.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-smdkv310.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-universal_c210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mct.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/platsmp.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/pm.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/pmu.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-fimc.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-fimd0.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c0.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c1.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c2.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c3.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c4.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c5.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c6.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c7.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-keypad.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-sdhci-gpio.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-sdhci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-usb-phy.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/sleep.S (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bea81d0..21dbf01 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -781,8 +781,8 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS4
-	bool "Samsung EXYNOS4"
+config ARCH_EXYNOS
+	bool "SAMSUNG EXYNOS"
 	select CPU_V7
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -795,7 +795,7 @@ config ARCH_EXYNOS4
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
-	  Samsung EXYNOS4 series based systems
+	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
 config ARCH_SHARK
 	bool "Shark"
@@ -1021,7 +1021,7 @@ source "arch/arm/mach-s5pc100/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
 
-source "arch/arm/mach-exynos4/Kconfig"
+source "arch/arm/mach-exynos/Kconfig"
 
 source "arch/arm/mach-shmobile/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 70c424e..289439e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -177,7 +177,7 @@ machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
-machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos4
+machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
diff --git a/arch/arm/configs/exynos4_defconfig b/arch/arm/configs/exynos4_defconfig
index cd40bb5..b0d3c13 100644
--- a/arch/arm/configs/exynos4_defconfig
+++ b/arch/arm/configs/exynos4_defconfig
@@ -4,10 +4,9 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_EXYNOS4=y
+CONFIG_ARCH_EXYNOS=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDKC210=y
-CONFIG_MACH_SMDKV310=y
 CONFIG_MACH_ARMLEX4210=y
 CONFIG_MACH_UNIVERSAL_C210=y
 CONFIG_MACH_NURI=y
@@ -16,7 +15,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
@@ -61,12 +59,9 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_S3C_UART=1
diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos/Kconfig
similarity index 91%
rename from arch/arm/mach-exynos4/Kconfig
rename to arch/arm/mach-exynos/Kconfig
index 6dfde07..999989e 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -1,4 +1,4 @@
-# arch/arm/mach-exynos4/Kconfig
+# arch/arm/mach-exynos/Kconfig
 #
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
@@ -7,21 +7,42 @@
 
 # Configuration options for the EXYNOS4
 
-if ARCH_EXYNOS4
+if ARCH_EXYNOS
+
+menu "SAMSUNG EXYNOS SoCs Support"
+
+choice
+	prompt "EXYNOS System Type"
+	default ARCH_EXYNOS4
+
+config ARCH_EXYNOS4
+	bool "SAMSUNG EXYNOS4"
+	help
+	  Samsung EXYNOS4 SoCs based systems
+
+endchoice
+
+comment "EXYNOS SoCs"
 
 config CPU_EXYNOS4210
-	bool
+	bool "SAMSUNG EXYNOS4210"
+	default y
+	depends on ARCH_EXYNOS4
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
 
 config SOC_EXYNOS4212
-	bool
+	bool "SAMSUNG EXYNOS4212"
+	default y
+	depends on ARCH_EXYNOS4
 	help
 	  Enable EXYNOS4212 SoC support
 
 config SOC_EXYNOS4412
-	bool
+	bool "SAMSUNG EXYNOS4412"
+	default y
+	depends on ARCH_EXYNOS4
 	help
 	  Enable EXYNOS4412 SoC support
 
@@ -119,7 +140,7 @@ config EXYNOS4_SETUP_USB_PHY
 
 # machine support
 
-menu "EXYNOS4 Machines"
+if ARCH_EXYNOS4
 
 comment "EXYNOS4210 Boards"
 
@@ -286,12 +307,11 @@ config MACH_SMDK4412
 	select MACH_SMDK4212
 	help
 	  Machine support for Samsung SMDK4412
+endif
 
-endmenu
-
-comment "Configuration for HSMMC bus width"
+if ARCH_EXYNOS4
 
-menu "Use 8-bit bus width"
+comment "Configuration for HSMMC 8-bit bus width"
 
 config EXYNOS4_SDHCI_CH0_8BIT
 	bool "Channel 0 with 8-bit bus"
@@ -304,6 +324,7 @@ config EXYNOS4_SDHCI_CH2_8BIT
 	help
 	  Support HSMMC Channel 2 8-bit bus.
 	  If selected, Channel 3 is disabled.
+endif
 
 endmenu
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos/Makefile
similarity index 89%
rename from arch/arm/mach-exynos4/Makefile
rename to arch/arm/mach-exynos/Makefile
index c9b2e1f..fa715eb 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -1,4 +1,4 @@
-# arch/arm/mach-exynos4/Makefile
+# arch/arm/mach-exynos/Makefile
 #
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
@@ -12,8 +12,8 @@ obj-				:=
 
 # Core support for EXYNOS4 system
 
-obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= cpu.o init.o clock.o irq-combiner.o setup-i2c0.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= irq-eint.o dma.o pmu.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
@@ -39,7 +39,7 @@ obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 
 # device support
 
-obj-y					+= dev-audio.o
+obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
diff --git a/arch/arm/mach-exynos4/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
similarity index 100%
rename from arch/arm/mach-exynos4/Makefile.boot
rename to arch/arm/mach-exynos/Makefile.boot
diff --git a/arch/arm/mach-exynos4/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
similarity index 100%
rename from arch/arm/mach-exynos4/clock-exynos4210.c
rename to arch/arm/mach-exynos/clock-exynos4210.c
diff --git a/arch/arm/mach-exynos4/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
similarity index 100%
rename from arch/arm/mach-exynos4/clock-exynos4212.c
rename to arch/arm/mach-exynos/clock-exynos4212.c
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos/clock.c
similarity index 100%
rename from arch/arm/mach-exynos4/clock.c
rename to arch/arm/mach-exynos/clock.c
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos/cpu.c
similarity index 91%
rename from arch/arm/mach-exynos4/cpu.c
rename to arch/arm/mach-exynos/cpu.c
index 5b1765b..90ec247 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-exynos4/cpu.c
+/* linux/arch/arm/mach-exynos/cpu.c
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -40,28 +40,47 @@ extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
 
 /* Initial IO mappings */
-static struct map_desc exynos4_iodesc[] __initdata = {
+static struct map_desc exynos_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSTIMER),
+		.pfn		= __phys_to_pfn(EXYNOS_PA_SYSTIMER),
 		.length		= SZ_4K,
-		.type	 	= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_CMU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
-		.length		= SZ_128K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_PMU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_PMU),
+		.pfn		= __phys_to_pfn(EXYNOS_PA_PMU),
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_COMBINER),
+		.pfn		= __phys_to_pfn(EXYNOS_PA_COMBINER),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
+		.pfn		= __phys_to_pfn(EXYNOS_PA_GIC_CPU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
+		.pfn		= __phys_to_pfn(EXYNOS_PA_GIC_DIST),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(S3C_PA_UART),
+		.length		= SZ_512K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_CMU,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
+		.length		= SZ_128K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
 		.length		= SZ_8K,
@@ -92,11 +111,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_512K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
 		.length		= SZ_4K,
@@ -106,16 +120,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_CPU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_DIST),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
 	},
 };
 
@@ -137,7 +141,7 @@ static struct map_desc exynos4_iodesc1[] __initdata = {
 	},
 };
 
-static void exynos4_idle(void)
+static void exynos_idle(void)
 {
 	if (!need_resched())
 		cpu_do_idle();
@@ -151,12 +155,13 @@ static void exynos4_sw_reset(void)
 }
 
 /*
- * exynos4_map_io
+ * exynos_map_io
  *
  * register the standard cpu IO areas
  */
 void __init exynos4_map_io(void)
 {
+	iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
 	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
@@ -250,7 +255,6 @@ static int __init exynos4_core_init(void)
 {
 	return sysdev_class_register(&exynos4_sysclass);
 }
-
 core_initcall(exynos4_core_init);
 
 #ifdef CONFIG_CACHE_L2X0
@@ -279,15 +283,16 @@ static int __init exynos4_l2x0_cache_init(void)
 early_initcall(exynos4_l2x0_cache_init);
 #endif
 
-int __init exynos4_init(void)
+int __init exynos_init(void)
 {
-	printk(KERN_INFO "EXYNOS4: Initializing architecture\n");
+	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
 
 	/* set idle function */
-	pm_idle = exynos4_idle;
+	pm_idle = exynos_idle;
 
 	/* set sw_reset function */
-	s5p_reset_hook = exynos4_sw_reset;
+	if (soc_is_exynos4210() || soc_is_exynos4212() || soc_is_exynos4412())
+		s5p_reset_hook = exynos4_sw_reset;
 
 	return sysdev_register(&exynos4_sysdev);
 }
diff --git a/arch/arm/mach-exynos4/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
similarity index 100%
rename from arch/arm/mach-exynos4/cpuidle.c
rename to arch/arm/mach-exynos/cpuidle.c
diff --git a/arch/arm/mach-exynos4/dev-ahci.c b/arch/arm/mach-exynos/dev-ahci.c
similarity index 100%
rename from arch/arm/mach-exynos4/dev-ahci.c
rename to arch/arm/mach-exynos/dev-ahci.c
diff --git a/arch/arm/mach-exynos4/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
similarity index 100%
rename from arch/arm/mach-exynos4/dev-audio.c
rename to arch/arm/mach-exynos/dev-audio.c
diff --git a/arch/arm/mach-exynos4/dev-dwmci.c b/arch/arm/mach-exynos/dev-dwmci.c
similarity index 100%
rename from arch/arm/mach-exynos4/dev-dwmci.c
rename to arch/arm/mach-exynos/dev-dwmci.c
diff --git a/arch/arm/mach-exynos4/dev-pd.c b/arch/arm/mach-exynos/dev-pd.c
similarity index 100%
rename from arch/arm/mach-exynos4/dev-pd.c
rename to arch/arm/mach-exynos/dev-pd.c
diff --git a/arch/arm/mach-exynos4/dev-sysmmu.c b/arch/arm/mach-exynos/dev-sysmmu.c
similarity index 100%
rename from arch/arm/mach-exynos4/dev-sysmmu.c
rename to arch/arm/mach-exynos/dev-sysmmu.c
diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos/dma.c
similarity index 100%
rename from arch/arm/mach-exynos4/dma.c
rename to arch/arm/mach-exynos/dma.c
diff --git a/arch/arm/mach-exynos4/headsmp.S b/arch/arm/mach-exynos/headsmp.S
similarity index 100%
rename from arch/arm/mach-exynos4/headsmp.S
rename to arch/arm/mach-exynos/headsmp.S
diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos/hotplug.c
similarity index 100%
rename from arch/arm/mach-exynos4/hotplug.c
rename to arch/arm/mach-exynos/hotplug.c
diff --git a/arch/arm/mach-exynos4/include/mach/debug-macro.S b/arch/arm/mach-exynos/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/debug-macro.S
rename to arch/arm/mach-exynos/include/mach/debug-macro.S
diff --git a/arch/arm/mach-exynos4/include/mach/dma.h b/arch/arm/mach-exynos/include/mach/dma.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/dma.h
rename to arch/arm/mach-exynos/include/mach/dma.h
diff --git a/arch/arm/mach-exynos4/include/mach/dwmci.h b/arch/arm/mach-exynos/include/mach/dwmci.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/dwmci.h
rename to arch/arm/mach-exynos/include/mach/dwmci.h
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos/include/mach/entry-macro.S
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/entry-macro.S
rename to arch/arm/mach-exynos/include/mach/entry-macro.S
diff --git a/arch/arm/mach-exynos4/include/mach/exynos4-clock.h b/arch/arm/mach-exynos/include/mach/exynos4-clock.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/exynos4-clock.h
rename to arch/arm/mach-exynos/include/mach/exynos4-clock.h
diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/gpio.h
rename to arch/arm/mach-exynos/include/mach/gpio.h
diff --git a/arch/arm/mach-exynos4/include/mach/hardware.h b/arch/arm/mach-exynos/include/mach/hardware.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/hardware.h
rename to arch/arm/mach-exynos/include/mach/hardware.h
diff --git a/arch/arm/mach-exynos4/include/mach/io.h b/arch/arm/mach-exynos/include/mach/io.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/io.h
rename to arch/arm/mach-exynos/include/mach/io.h
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/irqs.h
rename to arch/arm/mach-exynos/include/mach/irqs.h
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
similarity index 93%
rename from arch/arm/mach-exynos4/include/mach/map.h
rename to arch/arm/mach-exynos/include/mach/map.h
index 918a979..058541d 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-exynos4/include/mach/map.h
+/* linux/arch/arm/mach-exynos/include/mach/map.h
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -145,39 +145,45 @@
 #define S3C_PA_IIC5			EXYNOS4_PA_IIC(5)
 #define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
 #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
-#define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
-#define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
+#define S3C_PA_UART			EXYNOS4_PA_UART
 
 #define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
+#define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
 #define S5P_PA_FIMC1			EXYNOS4_PA_FIMC1
 #define S5P_PA_FIMC2			EXYNOS4_PA_FIMC2
 #define S5P_PA_FIMC3			EXYNOS4_PA_FIMC3
+#define S5P_PA_FIMD0			EXYNOS4_PA_FIMD0
+#define S5P_PA_HDMI			EXYNOS4_PA_HDMI
+#define S5P_PA_IIC_HDMIPHY		EXYNOS4_PA_IIC_HDMIPHY
+#define S5P_PA_MFC			EXYNOS4_PA_MFC
 #define S5P_PA_MIPI_CSIS0		EXYNOS4_PA_MIPI_CSIS0
 #define S5P_PA_MIPI_CSIS1		EXYNOS4_PA_MIPI_CSIS1
-#define S5P_PA_FIMD0			EXYNOS4_PA_FIMD0
+#define S5P_PA_MIXER			EXYNOS4_PA_MIXER
 #define S5P_PA_ONENAND			EXYNOS4_PA_ONENAND
 #define S5P_PA_ONENAND_DMA		EXYNOS4_PA_ONENAND_DMA
+#define S5P_PA_SDO			EXYNOS4_PA_SDO
 #define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
 #define S5P_PA_SROMC			EXYNOS4_PA_SROMC
-#define S5P_PA_MFC			EXYNOS4_PA_MFC
 #define S5P_PA_SYSCON			EXYNOS4_PA_SYSCON
 #define S5P_PA_TIMER			EXYNOS4_PA_TIMER
-#define S5P_PA_EHCI			EXYNOS4_PA_EHCI
-
-#define S5P_PA_SDO			EXYNOS4_PA_SDO
 #define S5P_PA_VP			EXYNOS4_PA_VP
-#define S5P_PA_MIXER			EXYNOS4_PA_MIXER
-#define S5P_PA_HDMI			EXYNOS4_PA_HDMI
-#define S5P_PA_IIC_HDMIPHY		EXYNOS4_PA_IIC_HDMIPHY
 
+#define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
+#define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
 
-/* UART */
+#define EXYNOS_PA_COMBINER		EXYNOS4_PA_COMBINER
+#define EXYNOS_PA_GIC_CPU		EXYNOS4_PA_GIC_CPU
+#define EXYNOS_PA_GIC_DIST		EXYNOS4_PA_GIC_DIST
+#define EXYNOS_PA_PMU			EXYNOS4_PA_PMU
+#define EXYNOS_PA_SYSTIMER		EXYNOS4_PA_SYSTIMER
 
-#define S3C_PA_UART			EXYNOS4_PA_UART
+/* Compatibility UART */
+
+#define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
 #define S5P_PA_UART(x)			(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
 #define S5P_PA_UART0			S5P_PA_UART(0)
diff --git a/arch/arm/mach-exynos4/include/mach/memory.h b/arch/arm/mach-exynos/include/mach/memory.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/memory.h
rename to arch/arm/mach-exynos/include/mach/memory.h
diff --git a/arch/arm/mach-exynos4/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/pm-core.h
rename to arch/arm/mach-exynos/include/mach/pm-core.h
diff --git a/arch/arm/mach-exynos4/include/mach/pmu.h b/arch/arm/mach-exynos/include/mach/pmu.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/pmu.h
rename to arch/arm/mach-exynos/include/mach/pmu.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-audss.h b/arch/arm/mach-exynos/include/mach/regs-audss.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-audss.h
rename to arch/arm/mach-exynos/include/mach/regs-audss.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-clock.h
rename to arch/arm/mach-exynos/include/mach/regs-clock.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-gpio.h b/arch/arm/mach-exynos/include/mach/regs-gpio.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-gpio.h
rename to arch/arm/mach-exynos/include/mach/regs-gpio.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-irq.h b/arch/arm/mach-exynos/include/mach/regs-irq.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-irq.h
rename to arch/arm/mach-exynos/include/mach/regs-irq.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-mct.h b/arch/arm/mach-exynos/include/mach/regs-mct.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-mct.h
rename to arch/arm/mach-exynos/include/mach/regs-mct.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-mem.h b/arch/arm/mach-exynos/include/mach/regs-mem.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-mem.h
rename to arch/arm/mach-exynos/include/mach/regs-mem.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-pmu.h
rename to arch/arm/mach-exynos/include/mach/regs-pmu.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h b/arch/arm/mach-exynos/include/mach/regs-sysmmu.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
rename to arch/arm/mach-exynos/include/mach/regs-sysmmu.h
diff --git a/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h b/arch/arm/mach-exynos/include/mach/regs-usb-phy.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
rename to arch/arm/mach-exynos/include/mach/regs-usb-phy.h
diff --git a/arch/arm/mach-exynos4/include/mach/sysmmu.h b/arch/arm/mach-exynos/include/mach/sysmmu.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/sysmmu.h
rename to arch/arm/mach-exynos/include/mach/sysmmu.h
diff --git a/arch/arm/mach-exynos4/include/mach/system.h b/arch/arm/mach-exynos/include/mach/system.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/system.h
rename to arch/arm/mach-exynos/include/mach/system.h
diff --git a/arch/arm/mach-exynos4/include/mach/timex.h b/arch/arm/mach-exynos/include/mach/timex.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/timex.h
rename to arch/arm/mach-exynos/include/mach/timex.h
diff --git a/arch/arm/mach-exynos4/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/uncompress.h
rename to arch/arm/mach-exynos/include/mach/uncompress.h
diff --git a/arch/arm/mach-exynos4/include/mach/vmalloc.h b/arch/arm/mach-exynos/include/mach/vmalloc.h
similarity index 100%
rename from arch/arm/mach-exynos4/include/mach/vmalloc.h
rename to arch/arm/mach-exynos/include/mach/vmalloc.h
diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos/init.c
similarity index 100%
rename from arch/arm/mach-exynos4/init.c
rename to arch/arm/mach-exynos/init.c
diff --git a/arch/arm/mach-exynos4/irq-combiner.c b/arch/arm/mach-exynos/irq-combiner.c
similarity index 100%
rename from arch/arm/mach-exynos4/irq-combiner.c
rename to arch/arm/mach-exynos/irq-combiner.c
diff --git a/arch/arm/mach-exynos4/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
similarity index 100%
rename from arch/arm/mach-exynos4/irq-eint.c
rename to arch/arm/mach-exynos/irq-eint.c
diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-armlex4210.c
rename to arch/arm/mach-exynos/mach-armlex4210.c
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-nuri.c
rename to arch/arm/mach-exynos/mach-nuri.c
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-origen.c
rename to arch/arm/mach-exynos/mach-origen.c
diff --git a/arch/arm/mach-exynos4/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-smdk4x12.c
rename to arch/arm/mach-exynos/mach-smdk4x12.c
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-smdkv310.c
rename to arch/arm/mach-exynos/mach-smdkv310.c
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
similarity index 100%
rename from arch/arm/mach-exynos4/mach-universal_c210.c
rename to arch/arm/mach-exynos/mach-universal_c210.c
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos/mct.c
similarity index 100%
rename from arch/arm/mach-exynos4/mct.c
rename to arch/arm/mach-exynos/mct.c
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos/platsmp.c
similarity index 100%
rename from arch/arm/mach-exynos4/platsmp.c
rename to arch/arm/mach-exynos/platsmp.c
diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos/pm.c
similarity index 100%
rename from arch/arm/mach-exynos4/pm.c
rename to arch/arm/mach-exynos/pm.c
diff --git a/arch/arm/mach-exynos4/pmu.c b/arch/arm/mach-exynos/pmu.c
similarity index 100%
rename from arch/arm/mach-exynos4/pmu.c
rename to arch/arm/mach-exynos/pmu.c
diff --git a/arch/arm/mach-exynos4/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-fimc.c
rename to arch/arm/mach-exynos/setup-fimc.c
diff --git a/arch/arm/mach-exynos4/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-fimd0.c
rename to arch/arm/mach-exynos/setup-fimd0.c
diff --git a/arch/arm/mach-exynos4/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c0.c
rename to arch/arm/mach-exynos/setup-i2c0.c
diff --git a/arch/arm/mach-exynos4/setup-i2c1.c b/arch/arm/mach-exynos/setup-i2c1.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c1.c
rename to arch/arm/mach-exynos/setup-i2c1.c
diff --git a/arch/arm/mach-exynos4/setup-i2c2.c b/arch/arm/mach-exynos/setup-i2c2.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c2.c
rename to arch/arm/mach-exynos/setup-i2c2.c
diff --git a/arch/arm/mach-exynos4/setup-i2c3.c b/arch/arm/mach-exynos/setup-i2c3.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c3.c
rename to arch/arm/mach-exynos/setup-i2c3.c
diff --git a/arch/arm/mach-exynos4/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c4.c
rename to arch/arm/mach-exynos/setup-i2c4.c
diff --git a/arch/arm/mach-exynos4/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c5.c
rename to arch/arm/mach-exynos/setup-i2c5.c
diff --git a/arch/arm/mach-exynos4/setup-i2c6.c b/arch/arm/mach-exynos/setup-i2c6.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c6.c
rename to arch/arm/mach-exynos/setup-i2c6.c
diff --git a/arch/arm/mach-exynos4/setup-i2c7.c b/arch/arm/mach-exynos/setup-i2c7.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-i2c7.c
rename to arch/arm/mach-exynos/setup-i2c7.c
diff --git a/arch/arm/mach-exynos4/setup-keypad.c b/arch/arm/mach-exynos/setup-keypad.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-keypad.c
rename to arch/arm/mach-exynos/setup-keypad.c
diff --git a/arch/arm/mach-exynos4/setup-sdhci-gpio.c b/arch/arm/mach-exynos/setup-sdhci-gpio.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-sdhci-gpio.c
rename to arch/arm/mach-exynos/setup-sdhci-gpio.c
diff --git a/arch/arm/mach-exynos4/setup-sdhci.c b/arch/arm/mach-exynos/setup-sdhci.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-sdhci.c
rename to arch/arm/mach-exynos/setup-sdhci.c
diff --git a/arch/arm/mach-exynos4/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
similarity index 100%
rename from arch/arm/mach-exynos4/setup-usb-phy.c
rename to arch/arm/mach-exynos/setup-usb-phy.c
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos/sleep.S
similarity index 100%
rename from arch/arm/mach-exynos4/sleep.S
rename to arch/arm/mach-exynos/sleep.S
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index f9241a7..4e98f09 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,7 +7,7 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS4)
+	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
 	default y
 	select ARM_VIC if !ARCH_EXYNOS4
 	select ARM_GIC if ARCH_EXYNOS4
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 7b0a28f..a56959e 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -75,7 +75,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos4_init,
+		.init		= exynos_init,
 		.name		= name_exynos4210,
 	}, {
 		.idcode		= EXYNOS4212_CPU_ID,
@@ -83,7 +83,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos4_init,
+		.init		= exynos_init,
 		.name		= name_exynos4212,
 	}, {
 		.idcode		= EXYNOS4412_CPU_ID,
@@ -91,7 +91,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos4_init,
+		.init		= exynos_init,
 		.name		= name_exynos4412,
 	},
 };
diff --git a/arch/arm/plat-samsung/include/plat/exynos4.h b/arch/arm/plat-samsung/include/plat/exynos4.h
index 20d73bf..f546e88 100644
--- a/arch/arm/plat-samsung/include/plat/exynos4.h
+++ b/arch/arm/plat-samsung/include/plat/exynos4.h
@@ -18,8 +18,8 @@ extern void exynos4210_register_clocks(void);
 extern void exynos4212_register_clocks(void);
 extern void exynos4_setup_clocks(void);
 
-#ifdef CONFIG_ARCH_EXYNOS4
-extern  int exynos4_init(void);
+#ifdef CONFIG_ARCH_EXYNOS
+extern  int exynos_init(void);
 extern void exynos4_init_irq(void);
 extern void exynos4_map_io(void);
 extern void exynos4_init_clocks(int xtal);
@@ -31,5 +31,5 @@ extern struct sys_timer exynos4_timer;
 #define exynos4_init_clocks NULL
 #define exynos4_init_uarts NULL
 #define exynos4_map_io NULL
-#define exynos4_init NULL
+#define exynos_init NULL
 #endif
-- 
1.7.1
