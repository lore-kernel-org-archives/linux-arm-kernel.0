From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:17 +0100
Subject: [PATCH 10/25] imx: rename Kconfig symbol for "LogicPD MX27 LITEKIT
	platform"
In-Reply-To: <1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not using MACH_IMX27LITE makes machine_is_imx27lite always return 0
independent of building support for this machine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Schaeffer <daniel.schaeffer@timesys.com>
---
 arch/arm/configs/mx27_defconfig |    2 +-
 arch/arm/mach-mx2/Kconfig       |    2 +-
 arch/arm/mach-mx2/Makefile      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index edfdd6f..b4c1366 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -200,7 +200,7 @@ CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
 CONFIG_MACH_PCM970_BASEBOARD=y
 CONFIG_MACH_MX27_3DS=y
-CONFIG_MACH_MX27LITE=y
+CONFIG_MACH_IMX27LITE=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 
diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index a8bc337..7bc797c 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -90,7 +90,7 @@ config MACH_MX27_3DS
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
-config MACH_MX27LITE
+config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
 	depends on MACH_MX27
 	help
diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index 2ba9997..a340698 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_MACH_MX27ADS) += mx27ads.o
 obj-$(CONFIG_MACH_PCM038) += pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
 obj-$(CONFIG_MACH_MX27_3DS) += mx27pdk.o
-obj-$(CONFIG_MACH_MX27LITE) += mx27lite.o
+obj-$(CONFIG_MACH_IMX27LITE) += mx27lite.o
 obj-$(CONFIG_MACH_CPUIMX27) += eukrea_cpuimx27.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += pca100.o
-- 
1.6.5.2
