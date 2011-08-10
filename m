From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:17:43 +0200
Subject: [PATCH 11/19] mach-ixp2000: rename GPIO header
Message-ID: <1312978663-18438-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The ixp2000 abuses the <mach/gpio.h> namespace by not implementing
any generic GPIO nor gpiolib functions in it - just custom GPIO.
Rename the header to <mach/gpio-ixp2000.h> for clarity.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp2000/core.c                       |    2 ++
 .../include/mach/{gpio.h => gpio-ixp2000.h}        |    0
 arch/arm/mach-ixp2000/ixdp2x00.c                   |    1 +
 drivers/i2c/busses/i2c-ixp2000.c                   |    2 +-
 4 files changed, 4 insertions(+), 1 deletions(-)
 rename arch/arm/mach-ixp2000/include/mach/{gpio.h => gpio-ixp2000.h} (100%)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index e95c5e7..59a5126 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -39,6 +39,8 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
+#include <mach/gpio-ixp2000.h>
+
 static DEFINE_SPINLOCK(ixp2000_slowport_lock);
 static unsigned long ixp2000_slowport_irq_flags;
 
diff --git a/arch/arm/mach-ixp2000/include/mach/gpio.h b/arch/arm/mach-ixp2000/include/mach/gpio-ixp2000.h
similarity index 100%
rename from arch/arm/mach-ixp2000/include/mach/gpio.h
rename to arch/arm/mach-ixp2000/include/mach/gpio-ixp2000.h
diff --git a/arch/arm/mach-ixp2000/ixdp2x00.c b/arch/arm/mach-ixp2000/ixdp2x00.c
index f615068..634b6c8 100644
--- a/arch/arm/mach-ixp2000/ixdp2x00.c
+++ b/arch/arm/mach-ixp2000/ixdp2x00.c
@@ -41,6 +41,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/arch.h>
 
+#include <mach/gpio-ixp2000.h>
 
 /*************************************************************************
  * IXDP2x00 IRQ Initialization
diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index be9991b..c01e951 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>	/* Pick up IXP2000-specific bits */
-#include <asm/gpio.h>
+#include <mach/gpio-ixp2000.h>
 
 static inline int ixp2000_scl_pin(void *data)
 {
-- 
1.7.3.2
