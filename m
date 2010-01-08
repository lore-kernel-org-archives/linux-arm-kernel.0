From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:18 +0100
Subject: [PATCH 11/25] imx/mx2: rename files defining a machine to mach-$mach.c
In-Reply-To: <1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric Benard <eric@eukrea.com>
---
 arch/arm/mach-mx2/Makefile                         |   17 ++++++++---------
 .../{eukrea_cpuimx27.c => mach-cpuimx27.c}         |    0
 arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} |    0
 arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c}    |    0
 arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c}   |    0
 arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c}    |    0
 arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c}  |    0
 arch/arm/mach-mx2/{pca100.c => mach-pca100.c}      |    0
 arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c}      |    0
 9 files changed, 8 insertions(+), 9 deletions(-)
 rename arch/arm/mach-mx2/{eukrea_cpuimx27.c => mach-cpuimx27.c} (100%)
 rename arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} (100%)
 rename arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c} (100%)
 rename arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c} (100%)
 rename arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c} (100%)
 rename arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c} (100%)
 rename arch/arm/mach-mx2/{pca100.c => mach-pca100.c} (100%)
 rename arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c} (100%)

diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index a340698..3710893 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -11,14 +11,13 @@ obj-$(CONFIG_MACH_MX21) += clock_imx21.o
 obj-$(CONFIG_MACH_MX27) += cpu_imx27.o
 obj-$(CONFIG_MACH_MX27) += clock_imx27.o
 
-obj-$(CONFIG_MACH_MX21ADS) += mx21ads.o
-obj-$(CONFIG_MACH_MX27ADS) += mx27ads.o
-obj-$(CONFIG_MACH_PCM038) += pcm038.o
+obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
+obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
+obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
-obj-$(CONFIG_MACH_MX27_3DS) += mx27pdk.o
-obj-$(CONFIG_MACH_IMX27LITE) += mx27lite.o
-obj-$(CONFIG_MACH_CPUIMX27) += eukrea_cpuimx27.o
+obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
+obj-$(CONFIG_MACH_IMX27LITE) += mach-imx27lite.o
+obj-$(CONFIG_MACH_CPUIMX27) += mach-cpuimx27.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
-obj-$(CONFIG_MACH_PCA100) += pca100.o
-obj-$(CONFIG_MACH_MXT_TD60) += mxt_td60.o
-
+obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
+obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
diff --git a/arch/arm/mach-mx2/eukrea_cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
similarity index 100%
rename from arch/arm/mach-mx2/eukrea_cpuimx27.c
rename to arch/arm/mach-mx2/mach-cpuimx27.c
diff --git a/arch/arm/mach-mx2/mx27lite.c b/arch/arm/mach-mx2/mach-imx27lite.c
similarity index 100%
rename from arch/arm/mach-mx2/mx27lite.c
rename to arch/arm/mach-mx2/mach-imx27lite.c
diff --git a/arch/arm/mach-mx2/mx21ads.c b/arch/arm/mach-mx2/mach-mx21ads.c
similarity index 100%
rename from arch/arm/mach-mx2/mx21ads.c
rename to arch/arm/mach-mx2/mach-mx21ads.c
diff --git a/arch/arm/mach-mx2/mx27pdk.c b/arch/arm/mach-mx2/mach-mx27_3ds.c
similarity index 100%
rename from arch/arm/mach-mx2/mx27pdk.c
rename to arch/arm/mach-mx2/mach-mx27_3ds.c
diff --git a/arch/arm/mach-mx2/mx27ads.c b/arch/arm/mach-mx2/mach-mx27ads.c
similarity index 100%
rename from arch/arm/mach-mx2/mx27ads.c
rename to arch/arm/mach-mx2/mach-mx27ads.c
diff --git a/arch/arm/mach-mx2/mxt_td60.c b/arch/arm/mach-mx2/mach-mxt_td60.c
similarity index 100%
rename from arch/arm/mach-mx2/mxt_td60.c
rename to arch/arm/mach-mx2/mach-mxt_td60.c
diff --git a/arch/arm/mach-mx2/pca100.c b/arch/arm/mach-mx2/mach-pca100.c
similarity index 100%
rename from arch/arm/mach-mx2/pca100.c
rename to arch/arm/mach-mx2/mach-pca100.c
diff --git a/arch/arm/mach-mx2/pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
similarity index 100%
rename from arch/arm/mach-mx2/pcm038.c
rename to arch/arm/mach-mx2/mach-pcm038.c
-- 
1.6.5.2
