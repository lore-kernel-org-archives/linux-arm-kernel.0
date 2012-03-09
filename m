From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 9 Mar 2012 14:57:56 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: Remove pcmcia platform_device structure
Message-ID: <1331305076.23513.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing pcmcia platform_device structure is not used and is not needed by
the pending hx4700 PCMCIA/CF support. So let's remove it.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V1:
This was originally included in the pending hx4700 PCMCIA/CF support, but it is
unrelated. Consequently this does not need to wait for the pending ARM SA11x0 /
PXA / SoC-common PCMCIA cleanups.

diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-09 13:40:26.332448626 +0000
@@ -788,17 +788,6 @@ static struct platform_device audio = {
 
 
 /*
- * PCMCIA
- */
-
-static struct platform_device pcmcia = {
-	.name = "hx4700-pcmcia",
-	.dev  = {
-		.parent = &asic3.dev,
-	},
-};
-
-/*
  * Platform devices
  */
 
@@ -814,7 +803,6 @@ static struct platform_device *devices[]
 	&power_supply,
 	&strataflash,
 	&audio,
-	&pcmcia,
 };
 
 static struct gpio global_gpios[] = {
