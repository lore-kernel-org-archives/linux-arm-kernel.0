From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 23 Jan 2010 22:04:37 +0100
Subject: [PATCH] Alter name of U300 watchdog resource
Message-ID: <1264280677-23498-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the bus name of the U300 watchdog from just "wdog"
to "coh901327_wdog" which is used to match the corresponding
driver. This makes the watchdog prope properly.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 068526a..6869052 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/core.c
  *
  *
- * Copyright (C) 2007-2009 ST-Ericsson AB
+ * Copyright (C) 2007-2010 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  * Core platform support, IRQ handling and device definitions.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
@@ -1400,7 +1400,7 @@ static struct coh901318_platform coh901318_platform = {
 };
 
 static struct platform_device wdog_device = {
-	.name = "wdog",
+	.name = "coh901327_wdog",
 	.id = -1,
 	.num_resources = ARRAY_SIZE(wdog_resources),
 	.resource = wdog_resources,
-- 
1.6.3.3
