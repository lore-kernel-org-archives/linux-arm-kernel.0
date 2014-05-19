From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 14:56:44 +0800
Subject: [PATCH 2/4] ARM: imx: drop option MACH_IMX51_DT
In-Reply-To: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
References: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400482606-8278-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since i.MX51 becomes DT only now, we can drop option MACH_IMX51_DT and
just use SOC_IMX51 instead.  While at it, rename imx51-dt.c to
mach-imx51.c to align with the name schema of other IMX DT only
platforms.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig           |  2 +-
 arch/arm/configs/multi_v7_defconfig            |  2 +-
 arch/arm/mach-imx/Kconfig                      | 10 +++-------
 arch/arm/mach-imx/Makefile                     |  2 +-
 arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c} |  0
 5 files changed, 6 insertions(+), 10 deletions(-)
 rename arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c} (100%)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ef88153..d8ec820 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -31,7 +31,7 @@ CONFIG_MACH_IMX35_DT=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_VPR200=y
-CONFIG_MACH_IMX51_DT=y
+CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX50=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..a045052 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -25,7 +25,7 @@ CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_IMX51_DT=y
+CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 19c609e..4dbe129 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -699,11 +699,6 @@ config SOC_IMX5
 	select HAVE_IMX_SRC
 	select MXC_TZIC
 
-config	SOC_IMX51
-	bool
-	select PINCTRL_IMX51
-	select SOC_IMX5
-
 config	SOC_IMX50
 	bool "i.MX50 support"
 	select PINCTRL_IMX50
@@ -712,9 +707,10 @@ config	SOC_IMX50
 	help
 	  This enables support for Freescale i.MX50 processor.
 
-config MACH_IMX51_DT
+config SOC_IMX51
 	bool "i.MX51 support"
-	select SOC_IMX51
+	select PINCTRL_IMX51
+	select SOC_IMX5
 	help
 	  This enables support for Freescale i.MX51 processor
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bbe93bb..9d7b46f 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -109,8 +109,8 @@ obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
-obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
+obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
 obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/mach-imx51.c
similarity index 100%
rename from arch/arm/mach-imx/imx51-dt.c
rename to arch/arm/mach-imx/mach-imx51.c
-- 
1.8.3.2
