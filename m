From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 20:14:23 +0300
Subject: [PATCH v3 12/14] omap: mailbox: standarize on 'omap-mailbox'
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274548465-20208-13-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap{1,2}-mailbox are modules that provide the 'omap-mailbox' driver.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    4 ++--
 arch/arm/mach-omap2/devices.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    6 ++----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 314fea3..16e43e5 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -87,7 +87,7 @@ static struct resource mbox_resources[] = {
 };
 
 static struct platform_device mbox_device = {
-	.name		= "omap1-mailbox",
+	.name		= "omap-mailbox",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mbox_resources),
 	.resource	= mbox_resources,
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 38c21a2..4210896 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -1,5 +1,5 @@
 /*
- * Mailbox reservation modules for DSP
+ * Mailbox reservation modules for OMAP1
  *
  * Copyright (C) 2006-2009 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
@@ -191,7 +191,7 @@ static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
 	.remove	= __devexit_p(omap1_mbox_remove),
 	.driver	= {
-		.name	= "omap1-mailbox",
+		.name	= "omap-mailbox",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b621476..d9ac853 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -206,7 +206,7 @@ static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
 #endif
 
 static struct platform_device mbox_device = {
-	.name		= "omap2-mailbox",
+	.name		= "omap-mailbox",
 	.id		= -1,
 };
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 1f0c5cd..a433ca7 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -18,8 +18,6 @@
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
-#define DRV_NAME "omap2-mailbox"
-
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
 #define MAILBOX_SYSSTATUS		0x014
@@ -461,7 +459,7 @@ static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = DRV_NAME,
+		.name = "omap-mailbox",
 	},
 };
 
@@ -482,4 +480,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
 MODULE_AUTHOR("Paul Mundt");
-MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_ALIAS("platform:omap2-mailbox");
-- 
1.7.1
