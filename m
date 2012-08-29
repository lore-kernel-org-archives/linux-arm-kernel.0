From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:28 -0500
Subject: [PATCH 02/10] gpio: pxa: add explicit includes for cpu_is_X macros
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add the
necessary includes for cpu_is_X macros.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pxa.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 9cac88a..4d44e2f 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -27,6 +27,10 @@
 #include <linux/slab.h>
 
 #include <mach/irqs.h>
+#include <mach/hardware.h>
+#ifdef CONFIG_ARCH_MMP
+#include <mach/cputype.h>
+#endif
 
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
-- 
1.7.9.5
