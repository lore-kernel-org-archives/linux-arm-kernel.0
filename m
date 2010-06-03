From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu,  3 Jun 2010 03:50:10 +0200
Subject: [PATCH] pxa/z2: Fix flash layout to final version
Message-ID: <1275529810-589-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes flash layout to it's final version. Also, I fixed the
authorship information of this file as it's been totally reworked since Ken
released his last version.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 4cba5b6..967e8cb 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -3,8 +3,9 @@
  *
  *  Support for the Zipit Z2 Handheld device.
  *
- *  Author: 	Ken McGuire
- *  Created:	Jan 25, 2009
+ *  Copyright (C) 2009-2010 Marek Vasut <marek.vasut@gmail.com>
+ *
+ *  Based on research and code by: Ken McGuire
  *  Based on mainstone.c as modified for the Zipit Z2.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -158,21 +159,14 @@ static struct mtd_partition z2_flash_parts[] = {
 	{
 		.name	= "U-Boot Bootloader",
 		.offset	= 0x0,
-		.size	= 0x20000,
-	},
-	{
-		.name	= "Linux Kernel",
-		.offset	= 0x20000,
-		.size	= 0x220000,
-	},
-	{
-		.name	= "Filesystem",
-		.offset	= 0x240000,
-		.size	= 0x5b0000,
-	},
-	{
+		.size	= 0x40000,
+	}, {
 		.name	= "U-Boot Environment",
-		.offset	= 0x7f0000,
+		.offset	= 0x40000,
+		.size	= 0x60000,
+	}, {
+		.name	= "Flash",
+		.offset	= 0x60000,
 		.size	= MTDPART_SIZ_FULL,
 	},
 };
-- 
1.7.0
