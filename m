From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 16:54:44 -0700
Subject: [PATCH] ARM: OMAP1: Include gpio-omap.h for board-h2 and board-h3
Message-ID: <20120917234821.GL11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From de6ca33a96a6bf61fcb91d3d399703e19ead9d1e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 17 Sep 2012 16:24:20 -0700
Subject: [PATCH] ARM: OMAP1: Include gpio-omap.h for board-h2 and board-h3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Merge of the LED related changes with omap sparse IRQ and
hardware.h related changes causes a build issue otherwise:

arch/arm/mach-omap1/board-h2.c:319: error: implicit declaration of function ?OMAP_MPUIO?
arch/arm/mach-omap1/board-h2.c:319: error: initializer element is not constant
arch/arm/mach-omap1/board-h2.c:319: error: (near initialization for ?h2_gpio_led_pins[1].gpio?)

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Noticed this with current linux next and omap1_defconfig.
The arm-soc drivers branch builds fine, but merged
with omap-cleanup-sparseirq-for-v3.7 compile breaks.

I'll queue this into cleanup-fixes branch on top of the
omap-cleanup-sparseirq-for-v3.7 branch.

--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
