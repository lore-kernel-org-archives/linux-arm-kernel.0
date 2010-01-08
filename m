From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:16 +0100
Subject: [PATCH 09/25] imx: rename Kconfig symbol for "Eukrea CPUIMX27 module"
In-Reply-To: <1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not using MACH_CPUIMX27 makes machine_is_cpuimx27 always return 0
independent of building support for this machine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Eric Benard <eric@eukrea.com>
---
 arch/arm/mach-mx2/Kconfig  |    6 +++---
 arch/arm/mach-mx2/Makefile |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index b96c6a3..a8bc337 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -55,7 +55,7 @@ config MACH_PCM970_BASEBOARD
 
 endchoice
 
-config MACH_EUKREA_CPUIMX27
+config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
 	depends on MACH_MX27
 	help
@@ -64,14 +64,14 @@ config MACH_EUKREA_CPUIMX27
 
 config MACH_EUKREA_CPUIMX27_USESDHC2
 	bool "CPUIMX27 integrates SDHC2 module"
-	depends on MACH_EUKREA_CPUIMX27
+	depends on MACH_CPUIMX27
 	help
 	  This adds support for the internal SDHC2 used on CPUIMX27 used
 	  for wifi or eMMC.
 
 choice
 	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX27
+	depends on MACH_CPUIMX27
 	default MACH_EUKREA_MBIMX27_BASEBOARD
 
 config MACH_EUKREA_MBIMX27_BASEBOARD
diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index 52aca0a..2ba9997 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_MACH_PCM038) += pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
 obj-$(CONFIG_MACH_MX27_3DS) += mx27pdk.o
 obj-$(CONFIG_MACH_MX27LITE) += mx27lite.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX27) += eukrea_cpuimx27.o
+obj-$(CONFIG_MACH_CPUIMX27) += eukrea_cpuimx27.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += pca100.o
 obj-$(CONFIG_MACH_MXT_TD60) += mxt_td60.o
-- 
1.6.5.2
