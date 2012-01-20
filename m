From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:00 -0600
Subject: [PATCH v2 02/13] gpio: pxa: explicitly include mach/irqs.h
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to make mach/irqs.h optional and remove from asm/irq.h,
directly include mach/irq.h to get MMP_GPIO_TO_IRQ and PXA_GPIO_TO_IRQ.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/gpio/gpio-pxa.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index b2d3ee1..5689ce6 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -22,6 +22,8 @@
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
+#include <mach/irqs.h>
+
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
  * one set of registers. The register offsets are organized below:
-- 
1.7.5.4
