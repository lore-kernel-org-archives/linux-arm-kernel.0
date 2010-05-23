From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 May 2010 10:42:20 +0100
Subject: [PATCH] ARM: Continue removing useless bootmem.h includes
Message-ID: <20100523094220.GB950@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catch those which have been missed by 6262c92f because they were
submitted via other routes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I'm working towards reducing ARM's usage of the bootmem code, with a
view to eventually removing it entirely.  As nothing in these files
uses bootmem, we can kill off the include.

Ack would be preferable.

 arch/arm/mach-msm/board-msm7x27.c |    1 -
 arch/arm/mach-msm/board-msm7x30.c |    1 -
 arch/arm/mach-msm/board-qsd8x50.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index cccb9f3..db9381b 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -20,7 +20,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/power_supply.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index bac1f3c..e329819 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -20,7 +20,6 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index ec46066..e3cc807 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -19,7 +19,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-#include <linux/bootmem.h>
 #include <linux/delay.h>
 
 #include <asm/mach-types.h>
