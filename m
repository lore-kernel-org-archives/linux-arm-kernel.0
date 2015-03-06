From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  6 Mar 2015 10:52:27 -0300
Subject: [PATCH 2/3] ARM: mx25: Convert to a dt-only platform
In-Reply-To: <1425649948-451-1-git-send-email-festevam@gmail.com>
References: <1425649948-451-1-git-send-email-festevam@gmail.com>
Message-ID: <1425649948-451-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As there is no more mx25 board files, we can turn mx25 into a dt-only platform.

Rename imx25-dt.c to mach-imx25.c to be consistent with the other i.MX SoCs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig                      | 28 +++++++++++++-------------
 arch/arm/mach-imx/Makefile                     |  5 +----
 arch/arm/mach-imx/{imx25-dt.c => mach-imx25.c} |  0
 3 files changed, 15 insertions(+), 18 deletions(-)
 rename arch/arm/mach-imx/{imx25-dt.c => mach-imx25.c} (100%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6eec625..ddbb4b8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -77,13 +77,6 @@ config SOC_IMX21
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 
-config SOC_IMX25
-	bool
-	select ARCH_MXC_IOMUX_V3
-	select CPU_ARM926T
-	select MXC_AVIC
-	select PINCTRL_IMX25
-
 config SOC_IMX27
 	bool
 	select CPU_ARM926T
@@ -149,13 +142,6 @@ config MACH_MX21ADS
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
-config MACH_IMX25_DT
-	bool "Support i.MX25 platforms from device tree"
-	select SOC_IMX25
-	help
-	  Include support for Freescale i.MX25 based platforms
-	  using the device tree for discovery
-
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
@@ -508,6 +494,20 @@ config MACH_VPR200
 
 endif
 
+if ARCH_MULTI_V5
+
+comment "Device tree only"
+
+config SOC_IMX25
+	bool "i.MX25 support"
+	select ARCH_MXC_IOMUX_V3
+	select CPU_ARM926T
+	select MXC_AVIC
+	select PINCTRL_IMX25
+	help
+	  This enables support for Freescale i.MX25 processor
+endif
+
 if ARCH_MULTI_V7
 
 comment "Device tree only"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 724b7fb..45f183a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -3,7 +3,7 @@ obj-y := time.o cpu.o system.o irq-common.o
 obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
 
-obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
+obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o mach-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
@@ -48,9 +48,6 @@ obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
-# i.MX25 based machines
-obj-$(CONFIG_MACH_IMX25_DT) += imx25-dt.o
-
 # i.MX27 based machines
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/mach-imx25.c
similarity index 100%
rename from arch/arm/mach-imx/imx25-dt.c
rename to arch/arm/mach-imx/mach-imx25.c
-- 
1.9.1
