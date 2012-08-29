From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:33 -0500
Subject: [PATCH 07/10] ARM: orion: add explict mach/gpio.h includes
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/irq.c                     |    1 +
 arch/arm/mach-dove/mpp.c                     |    1 +
 arch/arm/mach-kirkwood/irq.c                 |    1 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c |    1 +
 arch/arm/mach-mv78xx0/irq.c                  |    1 +
 arch/arm/mach-orion5x/d2net-setup.c          |    1 +
 arch/arm/mach-orion5x/dns323-setup.c         |    1 +
 arch/arm/mach-orion5x/irq.c                  |    1 +
 arch/arm/mach-orion5x/net2big-setup.c        |    1 +
 arch/arm/plat-orion/mpp.c                    |    1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 9bc97a5..6b30d76 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -18,6 +18,7 @@
 #include <asm/mach/irq.h>
 #include <mach/pm.h>
 #include <mach/bridge-regs.h>
+#include <mach/gpio.h>
 #include "common.h"
 
 static void pmu_irq_mask(struct irq_data *d)
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 7f70afc..f5851da 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <plat/mpp.h>
 #include <mach/dove.h>
+#include <mach/gpio.h>
 #include "mpp.h"
 
 struct dove_mpp_grp {
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
index 720063f..5dadebd 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-kirkwood/irq.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <mach/bridge-regs.h>
+#include <mach/gpio.h>
 #include <plat/irq.h>
 
 static int __initdata gpio0_irqs[4] = {
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index f742a66..8e5d470 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <mach/gpio.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index eff9a75..2b33bd7 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <mach/bridge-regs.h>
+#include <mach/gpio.h>
 #include <plat/irq.h>
 #include "common.h"
 
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index d75dcfa..39aecc8 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -26,6 +26,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
+#include <mach/gpio.h>
 #include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index d470864..b720804 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -33,6 +33,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
+#include <mach/gpio.h>
 #include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 17da709..bfdeab1 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <mach/bridge-regs.h>
+#include <mach/gpio.h>
 #include <plat/irq.h>
 
 static int __initdata gpio0_irqs[4] = {
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index 0180c39..472e9c6 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <mach/gpio.h>
 #include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
index 3b1e17b..c140c2f 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/plat-orion/mpp.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <mach/hardware.h>
+#include <plat/gpio.h>
 #include <plat/mpp.h>
 
 /* Address of the ith MPP control register */
-- 
1.7.9.5
