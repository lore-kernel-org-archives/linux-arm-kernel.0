From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:13 -0700
Subject: [PATCH 16/29] ARM: OMAP2+: Make omap-wakeupgen.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210613.28074.86348.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-hotplug.c                |    2 +-
 arch/arm/mach-omap2/omap-smp.c                    |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c              |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.h              |    0 
 arch/arm/mach-omap2/omap4-common.c                |    2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/omap-wakeupgen.h => omap-wakeupgen.h} (100%)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 414083b..765a2ac 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <mach/omap-wakeupgen.h>
+#include "omap-wakeupgen.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index cf2b32e..06d8bc3 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -25,7 +25,7 @@
 #include <asm/smp_scu.h>
 
 #include "omap-secure.h"
-#include <mach/omap-wakeupgen.h>
+#include "omap-wakeupgen.h"
 #include <asm/cputype.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 1729823..5d3b4f4 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -27,7 +27,7 @@
 
 #include <asm/hardware/gic.h>
 
-#include <mach/omap-wakeupgen.h>
+#include "omap-wakeupgen.h"
 #include "omap-secure.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
rename to arch/arm/mach-omap2/omap-wakeupgen.h
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 73c1440..9fc8655 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -29,7 +29,7 @@
 #include <plat/omap-secure.h>
 #include <plat/mmc.h>
 
-#include <mach/omap-wakeupgen.h>
+#include "omap-wakeupgen.h"
 
 #include "soc.h"
 #include "common.h"
