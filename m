From: Barry.Song@csr.com (Barry Song)
Date: Mon, 20 Aug 2012 16:19:46 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF series
 SoC
In-Reply-To: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345450787-17246-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

We will have SiRF Marco and Polo, so rename the dir to mach-sirf
and add Kconfig menu

Signed-off-by: Baohua Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig                                   |   10 +++++-----
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-sirf/Kconfig                         |   16 ++++++++++++++++
 arch/arm/{mach-prima2 => mach-sirf}/Makefile       |    0
 arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot  |    0
 .../arm/{mach-prima2 => mach-sirf}/board-generic.c |    0
 arch/arm/{mach-prima2 => mach-sirf}/common.h       |    0
 .../include/mach/clkdev.h                          |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/entry-macro.S                     |    0
 .../{mach-prima2 => mach-sirf}/include/mach/gpio.h |    0
 .../include/mach/hardware.h                        |    0
 .../{mach-prima2 => mach-sirf}/include/mach/irqs.h |    0
 .../{mach-prima2 => mach-sirf}/include/mach/map.h  |    0
 .../include/mach/timex.h                           |    0
 .../{mach-prima2 => mach-sirf}/include/mach/uart.h |    0
 .../include/mach/uncompress.h                      |    0
 arch/arm/{mach-prima2 => mach-sirf}/irq.c          |    0
 arch/arm/{mach-prima2 => mach-sirf}/l2x0.c         |    0
 arch/arm/{mach-prima2 => mach-sirf}/lluart.c       |    0
 arch/arm/{mach-prima2 => mach-sirf}/pm.c           |    0
 arch/arm/{mach-prima2 => mach-sirf}/pm.h           |    0
 arch/arm/{mach-prima2 => mach-sirf}/rstc.c         |    0
 arch/arm/{mach-prima2 => mach-sirf}/rtciobrg.c     |    0
 arch/arm/{mach-prima2 => mach-sirf}/sleep.S        |    0
 arch/arm/{mach-prima2 => mach-sirf}/timer.c        |    0
 26 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-sirf/Kconfig
 rename arch/arm/{mach-prima2 => mach-sirf}/Makefile (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/board-generic.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/common.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/clkdev.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/debug-macro.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/entry-macro.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/map.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/timex.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/uart.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/uncompress.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/irq.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/l2x0.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/lluart.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/pm.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/pm.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/rstc.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/rtciobrg.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/sleep.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/timer.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb60148..21cc08a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -407,9 +407,8 @@ config ARCH_GEMINI
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
-config ARCH_PRIMA2
-	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
-	select CPU_V7
+config ARCH_SIRF
+	bool "CSR SiRF"
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
@@ -419,9 +418,8 @@ config ARCH_PRIMA2
 	select PINCTRL
 	select PINCTRL_SIRF
 	select USE_OF
-	select ZONE_DMA
 	help
-          Support for CSR SiRFSoC ARM Cortex A9 Platform
+	  Support for CSR SiRFprimaII/Marco/Polo platforms
 
 config ARCH_EBSA110
 	bool "EBSA-110"
@@ -1118,6 +1116,8 @@ source "arch/arm/mach-exynos/Kconfig"
 
 source "arch/arm/mach-shmobile/Kconfig"
 
+source "arch/arm/mach-sirf/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..cc8da8e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -168,7 +168,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
-machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
+machine-$(CONFIG_ARCH_SIRF)		:= sirf
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
diff --git a/arch/arm/mach-sirf/Kconfig b/arch/arm/mach-sirf/Kconfig
new file mode 100644
index 0000000..811e782
--- /dev/null
+++ b/arch/arm/mach-sirf/Kconfig
@@ -0,0 +1,16 @@
+if ARCH_SIRF
+
+choice
+	prompt "Qualcomm SiRF SoC Type"
+	default ARCH_PRIMA2
+
+config ARCH_PRIMA2
+	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
+	select CPU_V7
+	select ZONE_DMA
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
+endchoice
+
+endif
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-sirf/Makefile
similarity index 100%
rename from arch/arm/mach-prima2/Makefile
rename to arch/arm/mach-sirf/Makefile
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-sirf/Makefile.boot
similarity index 100%
rename from arch/arm/mach-prima2/Makefile.boot
rename to arch/arm/mach-sirf/Makefile.boot
diff --git a/arch/arm/mach-prima2/board-generic.c b/arch/arm/mach-sirf/board-generic.c
similarity index 100%
rename from arch/arm/mach-prima2/board-generic.c
rename to arch/arm/mach-sirf/board-generic.c
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-sirf/common.h
similarity index 100%
rename from arch/arm/mach-prima2/common.h
rename to arch/arm/mach-sirf/common.h
diff --git a/arch/arm/mach-prima2/include/mach/clkdev.h b/arch/arm/mach-sirf/include/mach/clkdev.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/clkdev.h
rename to arch/arm/mach-sirf/include/mach/clkdev.h
diff --git a/arch/arm/mach-prima2/include/mach/debug-macro.S b/arch/arm/mach-sirf/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/debug-macro.S
rename to arch/arm/mach-sirf/include/mach/debug-macro.S
diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-sirf/include/mach/entry-macro.S
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/entry-macro.S
rename to arch/arm/mach-sirf/include/mach/entry-macro.S
diff --git a/arch/arm/mach-prima2/include/mach/gpio.h b/arch/arm/mach-sirf/include/mach/gpio.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/gpio.h
rename to arch/arm/mach-sirf/include/mach/gpio.h
diff --git a/arch/arm/mach-prima2/include/mach/hardware.h b/arch/arm/mach-sirf/include/mach/hardware.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/hardware.h
rename to arch/arm/mach-sirf/include/mach/hardware.h
diff --git a/arch/arm/mach-prima2/include/mach/irqs.h b/arch/arm/mach-sirf/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/irqs.h
rename to arch/arm/mach-sirf/include/mach/irqs.h
diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-sirf/include/mach/map.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/map.h
rename to arch/arm/mach-sirf/include/mach/map.h
diff --git a/arch/arm/mach-prima2/include/mach/timex.h b/arch/arm/mach-sirf/include/mach/timex.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/timex.h
rename to arch/arm/mach-sirf/include/mach/timex.h
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-sirf/include/mach/uart.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/uart.h
rename to arch/arm/mach-sirf/include/mach/uart.h
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-sirf/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/mach-prima2/include/mach/uncompress.h
rename to arch/arm/mach-sirf/include/mach/uncompress.h
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-sirf/irq.c
similarity index 100%
rename from arch/arm/mach-prima2/irq.c
rename to arch/arm/mach-sirf/irq.c
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-sirf/l2x0.c
similarity index 100%
rename from arch/arm/mach-prima2/l2x0.c
rename to arch/arm/mach-sirf/l2x0.c
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-sirf/lluart.c
similarity index 100%
rename from arch/arm/mach-prima2/lluart.c
rename to arch/arm/mach-sirf/lluart.c
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-sirf/pm.c
similarity index 100%
rename from arch/arm/mach-prima2/pm.c
rename to arch/arm/mach-sirf/pm.c
diff --git a/arch/arm/mach-prima2/pm.h b/arch/arm/mach-sirf/pm.h
similarity index 100%
rename from arch/arm/mach-prima2/pm.h
rename to arch/arm/mach-sirf/pm.h
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-sirf/rstc.c
similarity index 100%
rename from arch/arm/mach-prima2/rstc.c
rename to arch/arm/mach-sirf/rstc.c
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-sirf/rtciobrg.c
similarity index 100%
rename from arch/arm/mach-prima2/rtciobrg.c
rename to arch/arm/mach-sirf/rtciobrg.c
diff --git a/arch/arm/mach-prima2/sleep.S b/arch/arm/mach-sirf/sleep.S
similarity index 100%
rename from arch/arm/mach-prima2/sleep.S
rename to arch/arm/mach-sirf/sleep.S
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-sirf/timer.c
similarity index 100%
rename from arch/arm/mach-prima2/timer.c
rename to arch/arm/mach-sirf/timer.c
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
