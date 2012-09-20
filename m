From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:18 +0800
Subject: [PATCH v2 05/34] ARM: imx: merge plat-mxc into mach-imx
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's really unnecessary to have plat-mxc, and let's merge it into
mach-imx.  It's pretty much just a bunch of file renaming and
Kconfig/Makefile merge.

To make the change less invasive, we keep using Kconfig symbol
CONFIG_ARCH_MXC for mach-imx sub-architecture.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                        |    1 -
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/Makefile                                  |    1 -
 arch/arm/{plat-mxc => mach-imx}/3ds_debugboard.c   |    0
 arch/arm/mach-imx/Kconfig                          |   80 +++++++++++++++++++
 arch/arm/mach-imx/Makefile                         |   17 ++++
 arch/arm/{plat-mxc => mach-imx}/avic.c             |    0
 arch/arm/{plat-mxc => mach-imx}/cpu.c              |    0
 arch/arm/{plat-mxc => mach-imx}/cpufreq.c          |    0
 arch/arm/{plat-mxc => mach-imx}/cpuidle.c          |    0
 arch/arm/{plat-mxc => mach-imx}/epit.c             |    0
 .../{plat-mxc => mach-imx}/include/mach/common.h   |    0
 .../{plat-mxc => mach-imx}/include/mach/cpuidle.h  |    0
 .../include/mach/debug-macro.S                     |    0
 .../{plat-mxc => mach-imx}/include/mach/hardware.h |    0
 arch/arm/{plat-mxc => mach-imx}/include/mach/iim.h |    0
 arch/arm/{plat-mxc => mach-imx}/include/mach/ipu.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/iram.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/irqs.h |    0
 arch/arm/{plat-mxc => mach-imx}/include/mach/mx1.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx21.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx25.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx27.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx2x.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx31.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx35.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx3x.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx50.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx51.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx53.h |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/mx6q.h |    0
 arch/arm/{plat-mxc => mach-imx}/include/mach/mxc.h |    0
 .../{plat-mxc => mach-imx}/include/mach/timex.h    |    0
 .../arm/{plat-mxc => mach-imx}/include/mach/ulpi.h |    0
 .../include/mach/uncompress.h                      |    0
 arch/arm/{plat-mxc => mach-imx}/iram_alloc.c       |    0
 arch/arm/{plat-mxc => mach-imx}/irq-common.c       |    0
 arch/arm/{plat-mxc => mach-imx}/irq-common.h       |    0
 arch/arm/{plat-mxc => mach-imx}/ssi-fiq-ksym.c     |    0
 arch/arm/{plat-mxc => mach-imx}/ssi-fiq.S          |    0
 arch/arm/{plat-mxc => mach-imx}/system.c           |    0
 arch/arm/{plat-mxc => mach-imx}/time.c             |    0
 arch/arm/{plat-mxc => mach-imx}/tzic.c             |    0
 arch/arm/{plat-mxc => mach-imx}/ulpi.c             |    0
 arch/arm/plat-mxc/Kconfig                          |   81 --------------------
 arch/arm/plat-mxc/Makefile                         |   20 -----
 46 files changed, 98 insertions(+), 104 deletions(-)
 rename arch/arm/{plat-mxc => mach-imx}/3ds_debugboard.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/avic.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/cpu.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/cpufreq.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/cpuidle.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/epit.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/common.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/cpuidle.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/debug-macro.S (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/hardware.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/iim.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/ipu.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/iram.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/irqs.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx1.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx21.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx25.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx27.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx2x.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx31.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx35.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx3x.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx50.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx51.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx53.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mx6q.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/mxc.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/timex.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/ulpi.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/include/mach/uncompress.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/iram_alloc.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/irq-common.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/irq-common.h (100%)
 rename arch/arm/{plat-mxc => mach-imx}/ssi-fiq-ksym.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/ssi-fiq.S (100%)
 rename arch/arm/{plat-mxc => mach-imx}/system.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/time.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/tzic.c (100%)
 rename arch/arm/{plat-mxc => mach-imx}/ulpi.c (100%)
 delete mode 100644 arch/arm/plat-mxc/Kconfig
 delete mode 100644 arch/arm/plat-mxc/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 53cc13c..4aa276a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -776,7 +776,6 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
 F:	arch/arm/mach-imx/
-F:	arch/arm/plat-mxc/
 
 ARM/FREESCALE IMX6
 M:	Shawn Guo <shawn.guo@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e04d..6f82677 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1058,7 +1058,7 @@ source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
 
-source "arch/arm/plat-mxc/Kconfig"
+source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-mxs/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 13c7943..e3859c9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -196,7 +196,6 @@ machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_MXC)		+= mxc
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_ARCH_ZYNQ)	+= versatile
diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
similarity index 100%
rename from arch/arm/plat-mxc/3ds_debugboard.c
rename to arch/arm/mach-imx/3ds_debugboard.c
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8e1d4b8..d626f03 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,3 +1,54 @@
+if ARCH_MXC
+
+config MXC_IRQ_PRIOR
+	bool "Use IRQ priority"
+	help
+	  Select this if you want to use prioritized IRQ handling.
+	  This feature prevents higher priority ISR to be interrupted
+	  by lower priority IRQ even IRQF_DISABLED flag is not set.
+	  This may be useful in embedded applications, where are strong
+	  requirements for timing.
+	  Say N here, unless you have a specialized requirement.
+
+config MXC_TZIC
+	bool
+
+config MXC_AVIC
+	bool
+
+config MXC_DEBUG_BOARD
+	bool "Enable MXC debug board(for 3-stack)"
+	help
+	  The debug board is an integral part of the MXC 3-stack(PDK)
+	  platforms, it can be attached or removed from the peripheral
+	  board. On debug board, several debug devices(ethernet, UART,
+	  buttons, LEDs and JTAG) are implemented. Between the MCU and
+	  these devices, a CPLD is added as a bridge which performs
+	  data/address de-multiplexing and decode, signal level shift,
+	  interrupt control and various board functions.
+
+config HAVE_EPIT
+	bool
+
+config MXC_USE_EPIT
+	bool "Use EPIT instead of GPT"
+	depends on HAVE_EPIT
+	help
+	  Use EPIT as the system timer on systems that have it. Normally you
+	  don't have a reason to do so as the EPIT has the same features and
+	  uses the same clocks as the GPT. Anyway, on some systems the GPT
+	  may be in use for other purposes.
+
+config MXC_ULPI
+	bool
+
+config ARCH_HAS_RNGA
+	bool
+
+config IRAM_ALLOC
+	bool
+	select GENERIC_ALLOCATOR
+
 config HAVE_IMX_GPC
 	bool
 
@@ -110,6 +161,20 @@ config	SOC_IMX51
 	select PINCTRL
 	select PINCTRL_IMX51
 
+menu "Freescale MXC Implementations"
+
+choice
+	prompt "Freescale CPU family:"
+	default ARCH_IMX_V6_V7
+
+config ARCH_IMX_V4_V5
+	bool "i.MX1, i.MX21, i.MX25, i.MX27"
+	select AUTO_ZRELADDR if !ZBOOT_ROM
+	select ARM_PATCH_PHYS_VIRT
+	help
+	  This enables support for systems based on the Freescale i.MX ARMv4
+	  and ARMv5 SoCs
+
 if ARCH_IMX_V4_V5
 
 comment "MX1 platforms:"
@@ -389,6 +454,15 @@ config MACH_IMX27_DT
 
 endif
 
+config ARCH_IMX_V6_V7
+	bool "i.MX3, i.MX5, i.MX6"
+	select AUTO_ZRELADDR if !ZBOOT_ROM
+	select ARM_PATCH_PHYS_VIRT
+	select MIGHT_HAVE_CACHE_L2X0
+	help
+	  This enables support for systems based on the Freescale i.MX3, i.MX5
+	  and i.MX6 family.
+
 if ARCH_IMX_V6_V7
 
 comment "MX31 platforms:"
@@ -772,4 +846,10 @@ config SOC_IMX6Q
 
 endif
 
+endchoice
+
+endmenu
+
 source "arch/arm/mach-imx/devices/Kconfig"
+
+endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 257893e..fe47b71 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,3 +1,5 @@
+obj-y := time.o cpu.o system.o irq-common.o
+
 obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
 
@@ -18,6 +20,21 @@ obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 
+obj-$(CONFIG_MXC_TZIC) += tzic.o
+obj-$(CONFIG_MXC_AVIC) += avic.o
+
+obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
+obj-$(CONFIG_MXC_ULPI) += ulpi.o
+obj-$(CONFIG_MXC_USE_EPIT) += epit.o
+obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
+obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
+obj-$(CONFIG_CPU_IDLE) += cpuidle.o
+
+ifdef CONFIG_SND_IMX_SOC
+obj-y += ssi-fiq.o
+obj-y += ssi-fiq-ksym.o
+endif
+
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/mach-imx/avic.c
similarity index 100%
rename from arch/arm/plat-mxc/avic.c
rename to arch/arm/mach-imx/avic.c
diff --git a/arch/arm/plat-mxc/cpu.c b/arch/arm/mach-imx/cpu.c
similarity index 100%
rename from arch/arm/plat-mxc/cpu.c
rename to arch/arm/mach-imx/cpu.c
diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
similarity index 100%
rename from arch/arm/plat-mxc/cpufreq.c
rename to arch/arm/mach-imx/cpufreq.c
diff --git a/arch/arm/plat-mxc/cpuidle.c b/arch/arm/mach-imx/cpuidle.c
similarity index 100%
rename from arch/arm/plat-mxc/cpuidle.c
rename to arch/arm/mach-imx/cpuidle.c
diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/mach-imx/epit.c
similarity index 100%
rename from arch/arm/plat-mxc/epit.c
rename to arch/arm/mach-imx/epit.c
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/mach-imx/include/mach/common.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/common.h
rename to arch/arm/mach-imx/include/mach/common.h
diff --git a/arch/arm/plat-mxc/include/mach/cpuidle.h b/arch/arm/mach-imx/include/mach/cpuidle.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/cpuidle.h
rename to arch/arm/mach-imx/include/mach/cpuidle.h
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/mach-imx/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/debug-macro.S
rename to arch/arm/mach-imx/include/mach/debug-macro.S
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/mach-imx/include/mach/hardware.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/hardware.h
rename to arch/arm/mach-imx/include/mach/hardware.h
diff --git a/arch/arm/plat-mxc/include/mach/iim.h b/arch/arm/mach-imx/include/mach/iim.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iim.h
rename to arch/arm/mach-imx/include/mach/iim.h
diff --git a/arch/arm/plat-mxc/include/mach/ipu.h b/arch/arm/mach-imx/include/mach/ipu.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/ipu.h
rename to arch/arm/mach-imx/include/mach/ipu.h
diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/mach-imx/include/mach/iram.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/iram.h
rename to arch/arm/mach-imx/include/mach/iram.h
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/mach-imx/include/mach/irqs.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/irqs.h
rename to arch/arm/mach-imx/include/mach/irqs.h
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/mach-imx/include/mach/mx1.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx1.h
rename to arch/arm/mach-imx/include/mach/mx1.h
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/mach-imx/include/mach/mx21.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx21.h
rename to arch/arm/mach-imx/include/mach/mx21.h
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/mach-imx/include/mach/mx25.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx25.h
rename to arch/arm/mach-imx/include/mach/mx25.h
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/mach-imx/include/mach/mx27.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx27.h
rename to arch/arm/mach-imx/include/mach/mx27.h
diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/mach-imx/include/mach/mx2x.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx2x.h
rename to arch/arm/mach-imx/include/mach/mx2x.h
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/mach-imx/include/mach/mx31.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx31.h
rename to arch/arm/mach-imx/include/mach/mx31.h
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/mach-imx/include/mach/mx35.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx35.h
rename to arch/arm/mach-imx/include/mach/mx35.h
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/mach-imx/include/mach/mx3x.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx3x.h
rename to arch/arm/mach-imx/include/mach/mx3x.h
diff --git a/arch/arm/plat-mxc/include/mach/mx50.h b/arch/arm/mach-imx/include/mach/mx50.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx50.h
rename to arch/arm/mach-imx/include/mach/mx50.h
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/mach-imx/include/mach/mx51.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx51.h
rename to arch/arm/mach-imx/include/mach/mx51.h
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/mach-imx/include/mach/mx53.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx53.h
rename to arch/arm/mach-imx/include/mach/mx53.h
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/mach-imx/include/mach/mx6q.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mx6q.h
rename to arch/arm/mach-imx/include/mach/mx6q.h
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/mach-imx/include/mach/mxc.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/mxc.h
rename to arch/arm/mach-imx/include/mach/mxc.h
diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/mach-imx/include/mach/timex.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/timex.h
rename to arch/arm/mach-imx/include/mach/timex.h
diff --git a/arch/arm/plat-mxc/include/mach/ulpi.h b/arch/arm/mach-imx/include/mach/ulpi.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/ulpi.h
rename to arch/arm/mach-imx/include/mach/ulpi.h
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/mach-imx/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/plat-mxc/include/mach/uncompress.h
rename to arch/arm/mach-imx/include/mach/uncompress.h
diff --git a/arch/arm/plat-mxc/iram_alloc.c b/arch/arm/mach-imx/iram_alloc.c
similarity index 100%
rename from arch/arm/plat-mxc/iram_alloc.c
rename to arch/arm/mach-imx/iram_alloc.c
diff --git a/arch/arm/plat-mxc/irq-common.c b/arch/arm/mach-imx/irq-common.c
similarity index 100%
rename from arch/arm/plat-mxc/irq-common.c
rename to arch/arm/mach-imx/irq-common.c
diff --git a/arch/arm/plat-mxc/irq-common.h b/arch/arm/mach-imx/irq-common.h
similarity index 100%
rename from arch/arm/plat-mxc/irq-common.h
rename to arch/arm/mach-imx/irq-common.h
diff --git a/arch/arm/plat-mxc/ssi-fiq-ksym.c b/arch/arm/mach-imx/ssi-fiq-ksym.c
similarity index 100%
rename from arch/arm/plat-mxc/ssi-fiq-ksym.c
rename to arch/arm/mach-imx/ssi-fiq-ksym.c
diff --git a/arch/arm/plat-mxc/ssi-fiq.S b/arch/arm/mach-imx/ssi-fiq.S
similarity index 100%
rename from arch/arm/plat-mxc/ssi-fiq.S
rename to arch/arm/mach-imx/ssi-fiq.S
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/mach-imx/system.c
similarity index 100%
rename from arch/arm/plat-mxc/system.c
rename to arch/arm/mach-imx/system.c
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/mach-imx/time.c
similarity index 100%
rename from arch/arm/plat-mxc/time.c
rename to arch/arm/mach-imx/time.c
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/mach-imx/tzic.c
similarity index 100%
rename from arch/arm/plat-mxc/tzic.c
rename to arch/arm/mach-imx/tzic.c
diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/mach-imx/ulpi.c
similarity index 100%
rename from arch/arm/plat-mxc/ulpi.c
rename to arch/arm/mach-imx/ulpi.c
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
deleted file mode 100644
index 9ecaf06..0000000
--- a/arch/arm/plat-mxc/Kconfig
+++ /dev/null
@@ -1,81 +0,0 @@
-if ARCH_MXC
-
-menu "Freescale MXC Implementations"
-
-choice
-	prompt "Freescale CPU family:"
-	default ARCH_IMX_V6_V7
-
-config ARCH_IMX_V4_V5
-	bool "i.MX1, i.MX21, i.MX25, i.MX27"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select ARM_PATCH_PHYS_VIRT
-	help
-	  This enables support for systems based on the Freescale i.MX ARMv4
-	  and ARMv5 SoCs
-
-config ARCH_IMX_V6_V7
-	bool "i.MX3, i.MX5, i.MX6"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select ARM_PATCH_PHYS_VIRT
-	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  This enables support for systems based on the Freescale i.MX3, i.MX5
-	  and i.MX6 family.
-
-endchoice
-
-source "arch/arm/mach-imx/Kconfig"
-
-endmenu
-
-config MXC_IRQ_PRIOR
-	bool "Use IRQ priority"
-	help
-	  Select this if you want to use prioritized IRQ handling.
-	  This feature prevents higher priority ISR to be interrupted
-	  by lower priority IRQ even IRQF_DISABLED flag is not set.
-	  This may be useful in embedded applications, where are strong
-	  requirements for timing.
-	  Say N here, unless you have a specialized requirement.
-
-config MXC_TZIC
-	bool
-
-config MXC_AVIC
-	bool
-
-config MXC_DEBUG_BOARD
-	bool "Enable MXC debug board(for 3-stack)"
-	help
-	  The debug board is an integral part of the MXC 3-stack(PDK)
-	  platforms, it can be attached or removed from the peripheral
-	  board. On debug board, several debug devices(ethernet, UART,
-	  buttons, LEDs and JTAG) are implemented. Between the MCU and
-	  these devices, a CPLD is added as a bridge which performs
-	  data/address de-multiplexing and decode, signal level shift,
-	  interrupt control and various board functions.
-
-config HAVE_EPIT
-	bool
-
-config MXC_USE_EPIT
-	bool "Use EPIT instead of GPT"
-	depends on HAVE_EPIT
-	help
-	  Use EPIT as the system timer on systems that have it. Normally you
-	  don't have a reason to do so as the EPIT has the same features and
-	  uses the same clocks as the GPT. Anyway, on some systems the GPT
-	  may be in use for other purposes.
-
-config MXC_ULPI
-	bool
-
-config ARCH_HAS_RNGA
-	bool
-
-config IRAM_ALLOC
-	bool
-	select GENERIC_ALLOCATOR
-
-endif
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
deleted file mode 100644
index e33d2d1..0000000
--- a/arch/arm/plat-mxc/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Common support
-obj-y := time.o cpu.o system.o irq-common.o
-
-obj-$(CONFIG_MXC_TZIC) += tzic.o
-obj-$(CONFIG_MXC_AVIC) += avic.o
-
-obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
-obj-$(CONFIG_MXC_ULPI) += ulpi.o
-obj-$(CONFIG_MXC_USE_EPIT) += epit.o
-obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
-obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
-obj-$(CONFIG_CPU_IDLE) += cpuidle.o
-ifdef CONFIG_SND_IMX_SOC
-obj-y += ssi-fiq.o
-obj-y += ssi-fiq-ksym.o
-endif
-- 
1.7.9.5
