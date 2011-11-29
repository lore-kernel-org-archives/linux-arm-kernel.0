From: rachna@ti.com (Patil, Rachna)
Date: Tue, 29 Nov 2011 11:20:39 +0530
Subject: [PATCH] ARM: davinci: fix mach/gpio.h includes
Message-ID: <1322545839-30405-1-git-send-email-rachna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch addresses Russell's comments at [1] by replacing the
mach/gpio.h includes to linux/gpio.h for TI's DA830/OMAP-L137/AM17x and
DA850/OMAP-L138/AM18x platforms.

[1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/126553

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
 arch/arm/mach-davinci/da830.c |    2 +-
 arch/arm/mach-davinci/da850.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2ed2f82..ba15acf 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -10,6 +10,7 @@
  */
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 
@@ -19,7 +20,6 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
-#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0cf0d88..5d5dd6b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
+#include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 
 #include <asm/mach/map.h>
@@ -27,7 +28,6 @@
 #include <mach/da8xx.h>
 #include <mach/cpufreq.h>
 #include <mach/pm.h>
-#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
-- 
1.7.1
