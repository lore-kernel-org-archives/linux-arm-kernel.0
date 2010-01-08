From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:15 +0100
Subject: [PATCH 08/25] imx/mx1: rename files defining a machine to mach-$mach.c
In-Reply-To: <1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 arch/arm/mach-mx1/Makefile                      |    4 ++--
 arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c}   |    2 +-
 arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c} (98%)
 rename arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} (98%)

diff --git a/arch/arm/mach-mx1/Makefile b/arch/arm/mach-mx1/Makefile
index b72f536..297d172 100644
--- a/arch/arm/mach-mx1/Makefile
+++ b/arch/arm/mach-mx1/Makefile
@@ -10,5 +10,5 @@ obj-y			+= generic.o clock.o devices.o
 obj-$(CONFIG_MX1_VIDEO)	+= ksym_mx1.o mx1_camera_fiq.o
 
 # Specific board support
-obj-$(CONFIG_ARCH_MX1ADS) += mx1ads.o
-obj-$(CONFIG_MACH_SCB9328) += scb9328.o
+obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
+obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
diff --git a/arch/arm/mach-mx1/mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
similarity index 98%
rename from arch/arm/mach-mx1/mx1ads.c
rename to arch/arm/mach-mx1/mach-mx1ads.c
index 30f04e5..a39433a 100644
--- a/arch/arm/mach-mx1/mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-imx/mx1ads.c
+ * arch/arm/mach-imx/mach-mx1ads.c
  *
  * Initially based on:
  *	linux-2.6.7-imx/arch/arm/mach-imx/scb9328.c
diff --git a/arch/arm/mach-mx1/scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
similarity index 98%
rename from arch/arm/mach-mx1/scb9328.c
rename to arch/arm/mach-mx1/mach-scb9328.c
index 325d98d..b9530d7 100644
--- a/arch/arm/mach-mx1/scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-mx1/scb9328.c
+ * linux/arch/arm/mach-mx1/mach-scb9328.c
  *
  * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
  * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
-- 
1.6.5.2
