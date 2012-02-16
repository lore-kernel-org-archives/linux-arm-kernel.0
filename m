From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:45:20 +0100
Subject: [PATCH] arch/arm/mach-mmp/: some files include some headers twice
Message-ID: <1329403520-32551-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mmp/: some files include some headers twice:
- arch/arm/mach-mmp/aspenite.c and
  arch/arm/mach-mmp/tavorevb.c: 'linux/gpio.h'
- arch/arm/mach-mmp/pxa168.c: 'linux/platform_device.h'

Remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-mmp/aspenite.c |    1 -
 arch/arm/mach-mmp/pxa168.c   |    1 -
 arch/arm/mach-mmp/tavorevb.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 17cb760..3588a55 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -17,7 +17,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 7bc17ea..ada1213 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -24,7 +24,6 @@
 #include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <mach/pxa168.h>
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 8e3b5af0..bc97170 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-- 
1.7.8.3
