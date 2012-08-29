From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:30 -0500
Subject: [PATCH 04/10] net: pxaficp_ir: add explicit mach/gpio.h includes
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Samuel Ortiz <samuel@sortiz.org>
---
 drivers/net/irda/pxaficp_ir.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index 8d54767..e7e3e79 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -29,8 +29,9 @@
 
 #include <mach/dma.h>
 #include <mach/irda.h>
-#include <mach/regs-uart.h>
+#include <mach/irqs.h>
 #include <mach/regs-ost.h>
+#include <mach/regs-uart.h>
 
 #define FICP		__REG(0x40800000)  /* Start of FICP area */
 #define ICCR0		__REG(0x40800000)  /* ICP Control Register 0 */
-- 
1.7.9.5
