From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 30 Jul 2012 15:06:14 +0200
Subject: [PATCH v2] ARM: mxs: always build ocotp
Message-ID: <1343653574-31100-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch ocotp support will always be build into the kernel on mxs.
Otherwise a DT-only kernel fails to link with:

arch/arm/mach-mxs/mach-mxs.c:169: undefined reference to `mxs_get_ocotp'

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1
* always build ocotp as Shawn suggested.

 arch/arm/mach-mxs/Kconfig  |    6 ------
 arch/arm/mach-mxs/Makefile |    3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index ccdf83b..9a8bbda 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -2,9 +2,6 @@ if ARCH_MXS
 
 source "arch/arm/mach-mxs/devices/Kconfig"
 
-config MXS_OCOTP
-	bool
-
 config SOC_IMX23
 	bool
 	select ARM_AMBA
@@ -66,7 +63,6 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXS_SAIF
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
-	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -94,7 +90,6 @@ config MODULE_M28
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
-	select MXS_OCOTP
 
 config MODULE_APX4
 	bool
@@ -106,7 +101,6 @@ config MODULE_APX4
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXS_SAIF
-	select MXS_OCOTP
 
 config MACH_TX28
 	bool "Ka-Ro TX28 module"
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index e41590c..fed3695 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,7 +1,6 @@
 # Common support
-obj-y := devices.o icoll.o iomux.o system.o timer.o mm.o
+obj-y := devices.o icoll.o iomux.o ocotp.o system.o timer.o mm.o
 
-obj-$(CONFIG_MXS_OCOTP) += ocotp.o
 obj-$(CONFIG_PM) += pm.o
 
 obj-$(CONFIG_MACH_MXS_DT) += mach-mxs.o
-- 
1.7.10.4
