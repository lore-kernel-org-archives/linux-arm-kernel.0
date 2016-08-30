From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:41 +0100
Subject: [PATCH 4/8] ARM: sa1100/cerf: move cerf header file
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmX-0007IG-28@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing outside arch/arm/mach-sa1100 needs the cerf header file, so
move it into that directory.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/cerf.c                    | 3 ++-
 arch/arm/mach-sa1100/{include/mach => }/cerf.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
 rename arch/arm/mach-sa1100/{include/mach => }/cerf.h (89%)

diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 88e526561a24..0a32c32485be 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -30,9 +30,10 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/cerf.h>
 #include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
+
+#include "cerf.h"
 #include "generic.h"
 
 static struct resource cerfuart2_resources[] = {
diff --git a/arch/arm/mach-sa1100/include/mach/cerf.h b/arch/arm/mach-sa1100/cerf.h
similarity index 89%
rename from arch/arm/mach-sa1100/include/mach/cerf.h
rename to arch/arm/mach-sa1100/cerf.h
index f9f2222f013b..a47c82ed8fae 100644
--- a/arch/arm/mach-sa1100/include/mach/cerf.h
+++ b/arch/arm/mach-sa1100/cerf.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-sa1100/include/mach/cerf.h
+ * cerf.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
2.1.0
