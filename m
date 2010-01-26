From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:52 +0000
Subject: [PATCH] ARM: S3C64XX: Merge mach-s3c6400 and mach-s3c6410
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per discussions with Russell King on linux-arm-kernel, it appears that
both mach-s3c6400 and mach-s3c6410 are so close together that they should
simply be merged into mach-s3c64xx.

Note, this patch does not eliminate any of the bits that are still common,
it is simply a move of the two directories together, any further common
code will be eliminated or moved in further patches.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c6400/Kconfig                      |   30 --------------------
 arch/arm/mach-s3c6400/Makefile                     |   23 ---------------
 arch/arm/mach-s3c6410/Makefile                     |   26 -----------------
 arch/arm/{mach-s3c6410 => mach-s3c64xx}/Kconfig    |   30 ++++++++++++++++++-
 arch/arm/mach-s3c64xx/Makefile                     |   29 +++++++++++++++++++
 .../{mach-s3c6400 => mach-s3c64xx}/Makefile.boot   |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/dma.h                             |    0
 .../include/mach/entry-macro.S                     |    0
 .../include/mach/gpio.h                            |    0
 .../include/mach/hardware.h                        |    0
 .../include/mach/irqs.h                            |    0
 .../include/mach/map.h                             |    0
 .../include/mach/memory.h                          |    0
 .../include/mach/pwm-clock.h                       |    0
 .../include/mach/regs-clock.h                      |    0
 .../include/mach/regs-fb.h                         |    0
 .../include/mach/regs-irq.h                        |    0
 .../include/mach/system.h                          |    0
 .../include/mach/tick.h                            |    0
 .../include/mach/uncompress.h                      |    0
 .../{mach-s3c6410 => mach-s3c64xx}/mach-anw6410.c  |    2 +-
 arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-hmt.c |    0
 arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-ncp.c |    2 +-
 .../{mach-s3c6400 => mach-s3c64xx}/mach-smdk6400.c |    2 +-
 .../{mach-s3c6410 => mach-s3c64xx}/mach-smdk6410.c |    2 +-
 arch/arm/{mach-s3c6400 => mach-s3c64xx}/s3c6400.c  |    2 +-
 .../{mach-s3c6410/cpu.c => mach-s3c64xx/s3c6410.c} |    2 +-
 .../setup-sdhci-s3c6400.c}                         |    2 +-
 .../setup-sdhci-s3c6410.c}                         |    2 +-
 32 files changed, 67 insertions(+), 92 deletions(-)
 delete mode 100644 arch/arm/mach-s3c6400/Kconfig
 delete mode 100644 arch/arm/mach-s3c6400/Makefile
 delete mode 100644 arch/arm/mach-s3c6410/Makefile
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/Kconfig (84%)
 create mode 100644 arch/arm/mach-s3c64xx/Makefile
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/Makefile.boot (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/debug-macro.S (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/dma.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/entry-macro.S (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/map.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/memory.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/pwm-clock.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/regs-clock.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/regs-fb.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/regs-irq.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/system.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/tick.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/uncompress.h (100%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-anw6410.c (99%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-hmt.c (100%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-ncp.c (98%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/mach-smdk6400.c (98%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-smdk6410.c (99%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/s3c6400.c (98%)
 rename arch/arm/{mach-s3c6410/cpu.c => mach-s3c64xx/s3c6410.c} (98%)
 rename arch/arm/{mach-s3c6400/setup-sdhci.c => mach-s3c64xx/setup-sdhci-s3c6400.c} (97%)
 rename arch/arm/{mach-s3c6410/setup-sdhci.c => mach-s3c64xx/setup-sdhci-s3c6410.c} (97%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3bc5169..685ff7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -799,8 +799,7 @@ source "arch/arm/mach-s3c2443/Kconfig"
 endif
 
 if ARCH_S3C64XX
-source "arch/arm/mach-s3c6400/Kconfig"
-source "arch/arm/mach-s3c6410/Kconfig"
+source "arch/arm/mach-s3c64xx/Kconfig"
 endif
 
 source "arch/arm/mach-s5p6440/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index bbcd512..ecf963d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,7 +160,7 @@ machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
 machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
-machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
+machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
 machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
diff --git a/arch/arm/mach-s3c6400/Kconfig b/arch/arm/mach-s3c6400/Kconfig
deleted file mode 100644
index a250bf6..0000000
--- a/arch/arm/mach-s3c6400/Kconfig
+++ /dev/null
@@ -1,30 +0,0 @@
-# Copyright 2008 Openmoko, Inc.
-#	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
-#
-# Licensed under GPLv2
-
-# Configuration options for the S3C6410 CPU
-
-config CPU_S3C6400
-	bool
-	select CPU_S3C6400_INIT
-	select CPU_S3C6400_CLOCK
-	help
-	  Enable S3C6400 CPU support
-
-config S3C6400_SETUP_SDHCI
-	bool
-	help
-	  Internal configuration for default SDHCI
-	  setup for S3C6400.
-
-# S36400 Macchine support
-
-config MACH_SMDK6400
-       bool "SMDK6400"
-	select CPU_S3C6400
-	select S3C_DEV_HSMMC
-	select S3C_DEV_NAND
-	select S3C6400_SETUP_SDHCI
-	help
-	  Machine support for the Samsung SMDK6400
diff --git a/arch/arm/mach-s3c6400/Makefile b/arch/arm/mach-s3c6400/Makefile
deleted file mode 100644
index df1ce4a..0000000
--- a/arch/arm/mach-s3c6400/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-# arch/arm/mach-s3c6400/Makefile
-#
-# Copyright 2008 Openmoko, Inc.
-# Copyright 2008 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core support for S3C6400 system
-
-obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
-
-# setup support
-
-obj-$(CONFIG_S3C6400_SETUP_SDHCI) += setup-sdhci.o
-
-# Machine support
-
-obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
diff --git a/arch/arm/mach-s3c6410/Makefile b/arch/arm/mach-s3c6410/Makefile
deleted file mode 100644
index 3e48c3d..0000000
--- a/arch/arm/mach-s3c6410/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-# arch/arm/plat-s3c6410/Makefile
-#
-# Copyright 2008 Openmoko, Inc.
-# Copyright 2008 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core support for S3C6410 system
-
-obj-$(CONFIG_CPU_S3C6410)	+= cpu.o
-
-# Helper and device support
-
-obj-$(CONFIG_S3C6410_SETUP_SDHCI)	+= setup-sdhci.o
-
-# machine support
-
-obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
-obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
-obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
-obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
similarity index 84%
rename from arch/arm/mach-s3c6410/Kconfig
rename to arch/arm/mach-s3c64xx/Kconfig
index 162f456..551bb3f 100644
--- a/arch/arm/mach-s3c6410/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -1,10 +1,17 @@
 # Copyright 2008 Openmoko, Inc.
-# Copyright 2008 Simtec Electronics
+#	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
 #
 # Licensed under GPLv2
 
 # Configuration options for the S3C6410 CPU
 
+config CPU_S3C6400
+	bool
+	select CPU_S3C6400_INIT
+	select CPU_S3C6400_CLOCK
+	help
+	  Enable S3C6400 CPU support
+
 config CPU_S3C6410
 	bool
 	select CPU_S3C6400_INIT
@@ -12,12 +19,31 @@ config CPU_S3C6410
 	help
 	  Enable S3C6410 CPU support
 
+config S3C6400_SETUP_SDHCI
+	bool
+	help
+	  Internal configuration for default SDHCI
+	  setup for S3C6400.
+
 config S3C6410_SETUP_SDHCI
 	bool
 	select S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Internal helper functions for S3C6410 based SDHCI systems
 
+# S36400 Macchine support
+
+config MACH_SMDK6400
+       bool "SMDK6400"
+	select CPU_S3C6400
+	select S3C_DEV_HSMMC
+	select S3C_DEV_NAND
+	select S3C6400_SETUP_SDHCI
+	help
+	  Machine support for the Samsung SMDK6400
+
+# S3C6410 machine support
+
 config MACH_ANW6410
 	bool "A&W6410"
 	select CPU_S3C6410
@@ -58,7 +84,7 @@ config SMDK6410_SD_CH0
 	  at least some SMDK6410 boards come with the
 	  resistors fitted so that the card detects for
 	  channels 0 and 1 are the same.
-       
+
 config SMDK6410_SD_CH1
 	bool "Use channel 1 only"
 	depends on MACH_SMDK6410
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
new file mode 100644
index 0000000..24a3bc3
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -0,0 +1,29 @@
+# arch/arm/mach-s3c64xx/Makefile
+#
+# Copyright 2008 Openmoko, Inc.
+# Copyright 2008 Simtec Electronics
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for S3C6400 system
+
+obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
+obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
+
+# setup support
+
+obj-$(CONFIG_S3C6400_SETUP_SDHCI) += setup-sdhci-s3c6400.o
+obj-$(CONFIG_S3C6410_SETUP_SDHCI) += setup-sdhci-s3c6410.o
+
+# Machine support
+
+obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
+obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
+obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
+obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
+obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
diff --git a/arch/arm/mach-s3c6400/Makefile.boot b/arch/arm/mach-s3c64xx/Makefile.boot
similarity index 100%
rename from arch/arm/mach-s3c6400/Makefile.boot
rename to arch/arm/mach-s3c64xx/Makefile.boot
diff --git a/arch/arm/mach-s3c6400/include/mach/debug-macro.S b/arch/arm/mach-s3c64xx/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/debug-macro.S
rename to arch/arm/mach-s3c64xx/include/mach/debug-macro.S
diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/dma.h
rename to arch/arm/mach-s3c64xx/include/mach/dma.h
diff --git a/arch/arm/mach-s3c6400/include/mach/entry-macro.S b/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/entry-macro.S
rename to arch/arm/mach-s3c64xx/include/mach/entry-macro.S
diff --git a/arch/arm/mach-s3c6400/include/mach/gpio.h b/arch/arm/mach-s3c64xx/include/mach/gpio.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/gpio.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio.h
diff --git a/arch/arm/mach-s3c6400/include/mach/hardware.h b/arch/arm/mach-s3c64xx/include/mach/hardware.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/hardware.h
rename to arch/arm/mach-s3c64xx/include/mach/hardware.h
diff --git a/arch/arm/mach-s3c6400/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/irqs.h
rename to arch/arm/mach-s3c64xx/include/mach/irqs.h
diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/map.h
rename to arch/arm/mach-s3c64xx/include/mach/map.h
diff --git a/arch/arm/mach-s3c6400/include/mach/memory.h b/arch/arm/mach-s3c64xx/include/mach/memory.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/memory.h
rename to arch/arm/mach-s3c64xx/include/mach/memory.h
diff --git a/arch/arm/mach-s3c6400/include/mach/pwm-clock.h b/arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/pwm-clock.h
rename to arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
diff --git a/arch/arm/mach-s3c6400/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/regs-clock.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-clock.h
diff --git a/arch/arm/mach-s3c6400/include/mach/regs-fb.h b/arch/arm/mach-s3c64xx/include/mach/regs-fb.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/regs-fb.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-fb.h
diff --git a/arch/arm/mach-s3c6400/include/mach/regs-irq.h b/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/regs-irq.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-irq.h
diff --git a/arch/arm/mach-s3c6400/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/system.h
rename to arch/arm/mach-s3c64xx/include/mach/system.h
diff --git a/arch/arm/mach-s3c6400/include/mach/tick.h b/arch/arm/mach-s3c64xx/include/mach/tick.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/tick.h
rename to arch/arm/mach-s3c64xx/include/mach/tick.h
diff --git a/arch/arm/mach-s3c6400/include/mach/uncompress.h b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/mach-s3c6400/include/mach/uncompress.h
rename to arch/arm/mach-s3c64xx/include/mach/uncompress.h
diff --git a/arch/arm/mach-s3c6410/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
similarity index 99%
rename from arch/arm/mach-s3c6410/mach-anw6410.c
rename to arch/arm/mach-s3c64xx/mach-anw6410.c
index 661cca6..49032a8 100644
--- a/arch/arm/mach-s3c6410/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/mach-anw6410.c
+/* linux/arch/arm/mach-s3c64xx/mach-anw6410.c
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c6410/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
similarity index 100%
rename from arch/arm/mach-s3c6410/mach-hmt.c
rename to arch/arm/mach-s3c64xx/mach-hmt.c
diff --git a/arch/arm/mach-s3c6410/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
similarity index 98%
rename from arch/arm/mach-s3c6410/mach-ncp.c
rename to arch/arm/mach-s3c64xx/mach-ncp.c
index 55e9bbf..9be92dd 100644
--- a/arch/arm/mach-s3c6410/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s3c6410/mach-ncp.c
+ * linux/arch/arm/mach-s3c64xx/mach-ncp.c
  *
  * Copyright (C) 2008-2009 Samsung Electronics
  *
diff --git a/arch/arm/mach-s3c6400/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
similarity index 98%
rename from arch/arm/mach-s3c6400/mach-smdk6400.c
rename to arch/arm/mach-s3c64xx/mach-smdk6400.c
index ab19285..ba8a052 100644
--- a/arch/arm/mach-s3c6400/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6400/mach-smdk6400.c
+/* linux/arch/arm/mach-s3c64xx/mach-smdk6400.c
  *
  * Copyright 2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
similarity index 99%
rename from arch/arm/mach-s3c6410/mach-smdk6410.c
rename to arch/arm/mach-s3c64xx/mach-smdk6410.c
index eba345f..6e6ff35 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/mach-smdk6410.c
+/* linux/arch/arm/mach-s3c64xx/mach-smdk6410.c
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c6400/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
similarity index 98%
rename from arch/arm/mach-s3c6400/s3c6400.c
rename to arch/arm/mach-s3c64xx/s3c6400.c
index d876ee5..884858a 100644
--- a/arch/arm/mach-s3c6400/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/cpu.c
+/* linux/arch/arm/mach-s3c64xx/cpu.c
  *
  * Copyright 2009 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/mach-s3c6410/cpu.c b/arch/arm/mach-s3c64xx/s3c6410.c
similarity index 98%
rename from arch/arm/mach-s3c6410/cpu.c
rename to arch/arm/mach-s3c64xx/s3c6410.c
index 522c086..dd55c6a 100644
--- a/arch/arm/mach-s3c6410/cpu.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/cpu.c
+/* linux/arch/arm/mach-s3c64xx/s3c6410.c
  *
  * Copyright 2008 Simtec Electronics
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c6400/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c
similarity index 97%
rename from arch/arm/mach-s3c6400/setup-sdhci.c
rename to arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c
index 1039937..ec96a58 100644
--- a/arch/arm/mach-s3c6400/setup-sdhci.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-s3c6400.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/setup-sdhci.c
+/* linux/arch/arm/mach-s3c64xx/setup-sdhci.c
  *
  * Copyright 2008 Simtec Electronics
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c6410/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
similarity index 97%
rename from arch/arm/mach-s3c6410/setup-sdhci.c
rename to arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
index 816d2d9..8d714a1 100644
--- a/arch/arm/mach-s3c6410/setup-sdhci.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-s3c6410.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c6410/setup-sdhci.c
+/* linux/arch/arm/mach-s3c64xx/setup-sdhci.c
  *
  * Copyright 2008 Simtec Electronics
  * Copyright 2008 Simtec Electronics
-- 
1.6.0.4
