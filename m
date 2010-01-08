From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:19 +0100
Subject: [PATCH 12/25] imx/mx3: rename files defining a machine to mach-$mach.c
In-Reply-To: <1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it remove some superfluous parenthesis.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/Makefile                         |   24 ++++++++++----------
 .../{armadillo5x0.c => mach-armadillo5x0.c}        |    2 +-
 .../mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c}   |    2 +-
 arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c}   |    2 +-
 arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c}    |    2 +-
 .../arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} |    2 +-
 arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c}  |    2 +-
 .../mach-mx3/{mx31moboard.c => mach-mx31moboard.c} |    2 +-
 arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c}    |    0
 arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c}      |    2 +-
 .../mach-mx3/{pcm037_eet.c => mach-pcm037_eet.c}   |    0
 arch/arm/mach-mx3/{pcm043.c => mach-pcm043.c}      |    0
 arch/arm/mach-mx3/{qong.c => mach-qong.c}          |    2 +-
 13 files changed, 21 insertions(+), 21 deletions(-)
 rename arch/arm/mach-mx3/{armadillo5x0.c => mach-armadillo5x0.c} (99%)
 rename arch/arm/mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c} (99%)
 rename arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c} (99%)
 rename arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c} (99%)
 rename arch/arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} (98%)
 rename arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c} (99%)
 rename arch/arm/mach-mx3/{mx31moboard.c => mach-mx31moboard.c} (99%)
 rename arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c} (100%)
 rename arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c} (99%)
 rename arch/arm/mach-mx3/{pcm037_eet.c => mach-pcm037_eet.c} (100%)
 rename arch/arm/mach-mx3/{pcm043.c => mach-pcm043.c} (100%)
 rename arch/arm/mach-mx3/{qong.c => mach-qong.c} (99%)

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 03e25d6..670fbb5 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -7,16 +7,16 @@
 obj-y				:= mm.o devices.o cpu.o
 obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
-obj-$(CONFIG_MACH_MX31ADS)	+= mx31ads.o
-obj-$(CONFIG_MACH_MX31LILLY)	+= mx31lilly.o mx31lilly-db.o
-obj-$(CONFIG_MACH_MX31LITE)	+= mx31lite.o mx31lite-db.o
-obj-$(CONFIG_MACH_PCM037)	+= pcm037.o
-obj-$(CONFIG_MACH_PCM037_EET)	+= pcm037_eet.o
-obj-$(CONFIG_MACH_MX31_3DS)	+= mx31pdk.o
-obj-$(CONFIG_MACH_MX31MOBOARD)	+= mx31moboard.o mx31moboard-devboard.o \
+obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
+obj-$(CONFIG_MACH_MX31LILLY)	+= mach-mx31lilly.o mx31lilly-db.o
+obj-$(CONFIG_MACH_MX31LITE)	+= mach-mx31lite.o mx31lite-db.o
+obj-$(CONFIG_MACH_PCM037)	+= mach-pcm037.o
+obj-$(CONFIG_MACH_PCM037_EET)	+= mach-pcm037_eet.o
+obj-$(CONFIG_MACH_MX31_3DS)	+= mach-mx31_3ds.o
+obj-$(CONFIG_MACH_MX31MOBOARD)	+= mach-mx31moboard.o mx31moboard-devboard.o \
 				   mx31moboard-marxbot.o
-obj-$(CONFIG_MACH_QONG)		+= qong.o
-obj-$(CONFIG_MACH_PCM043)	+= pcm043.o
-obj-$(CONFIG_MACH_ARMADILLO5X0) += armadillo5x0.o
-obj-$(CONFIG_MACH_MX35_3DS)	+= mx35pdk.o
-obj-$(CONFIG_MACH_KZM_ARM11_01)	+= kzmarm11.o
+obj-$(CONFIG_MACH_QONG)		+= mach-qong.o
+obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
+obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
+obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35pdk.o
+obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
similarity index 99%
rename from arch/arm/mach-mx3/armadillo5x0.c
rename to arch/arm/mach-mx3/mach-armadillo5x0.c
index aac5f81..1fed146 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -407,7 +407,7 @@ static struct sys_timer armadillo5x0_timer = {
 MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	/* Maintainer: Alberto Panizzo  */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= mx31_map_io,
 	.init_irq	= mx31_init_irq,
diff --git a/arch/arm/mach-mx3/kzmarm11.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
similarity index 99%
rename from arch/arm/mach-mx3/kzmarm11.c
rename to arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 849631e..2850b0b 100644
--- a/arch/arm/mach-mx3/kzmarm11.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -259,7 +259,7 @@ static struct sys_timer kzm_timer = {
  */
 MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
 	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = kzm_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mx31pdk.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
similarity index 99%
rename from arch/arm/mach-mx3/mx31pdk.c
rename to arch/arm/mach-mx3/mach-mx31_3ds.c
index e71e3b4..88af585 100644
--- a/arch/arm/mach-mx3/mx31pdk.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -257,7 +257,7 @@ static struct sys_timer mx31pdk_timer = {
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31pdk_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
similarity index 99%
rename from arch/arm/mach-mx3/mx31ads.c
rename to arch/arm/mach-mx3/mach-mx31ads.c
index 6699116..1bcf226 100644
--- a/arch/arm/mach-mx3/mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -542,7 +542,7 @@ static struct sys_timer mx31ads_timer = {
 MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31ads_map_io,
 	.init_irq       = mx31ads_init_irq,
diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
similarity index 98%
rename from arch/arm/mach-mx3/mx31lilly.c
rename to arch/arm/mach-mx3/mach-mx31lilly.c
index ffccea9..9225cb7 100644
--- a/arch/arm/mach-mx3/mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -196,7 +196,7 @@ static struct sys_timer mx31lilly_timer = {
 
 MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= mx31_map_io,
 	.init_irq	= mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
similarity index 99%
rename from arch/arm/mach-mx3/mx31lite.c
rename to arch/arm/mach-mx3/mach-mx31lite.c
index 1e26397..8589e3d 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -288,7 +288,7 @@ struct sys_timer mx31lite_timer = {
 MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31lite_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
similarity index 99%
rename from arch/arm/mach-mx3/mx31moboard.c
rename to arch/arm/mach-mx3/mach-mx31moboard.c
index 9428827..63f991f 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -570,7 +570,7 @@ struct sys_timer mx31moboard_timer = {
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mx35pdk.c b/arch/arm/mach-mx3/mach-mx35pdk.c
similarity index 100%
rename from arch/arm/mach-mx3/mx35pdk.c
rename to arch/arm/mach-mx3/mach-mx35pdk.c
diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
similarity index 99%
rename from arch/arm/mach-mx3/pcm037.c
rename to arch/arm/mach-mx3/mach-pcm037.c
index 701fac9..d9bd7d2 100644
--- a/arch/arm/mach-mx3/pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -637,7 +637,7 @@ struct sys_timer pcm037_timer = {
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
similarity index 100%
rename from arch/arm/mach-mx3/pcm037_eet.c
rename to arch/arm/mach-mx3/mach-pcm037_eet.c
diff --git a/arch/arm/mach-mx3/pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
similarity index 100%
rename from arch/arm/mach-mx3/pcm043.c
rename to arch/arm/mach-mx3/mach-pcm043.c
diff --git a/arch/arm/mach-mx3/qong.c b/arch/arm/mach-mx3/mach-qong.c
similarity index 99%
rename from arch/arm/mach-mx3/qong.c
rename to arch/arm/mach-mx3/mach-qong.c
index 3c1e736..93991f1 100644
--- a/arch/arm/mach-mx3/qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -276,7 +276,7 @@ static struct sys_timer qong_timer = {
 MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	/* Maintainer: DENX Software Engineering GmbH */
 	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = ((MX31_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
-- 
1.6.5.2
