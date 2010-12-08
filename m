From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:08:00 +0530
Subject: [PATCH 8/9] ux500: modem_irq is only for 5500
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-8-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/modem_irq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/modem_irq.c b/arch/arm/mach-ux500/modem_irq.c
index 3187f88..e1296a7 100644
--- a/arch/arm/mach-ux500/modem_irq.c
+++ b/arch/arm/mach-ux500/modem_irq.c
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#include <mach/id.h>
+
 #define MODEM_INTCON_BASE_ADDR 0xBFFD3000
 #define MODEM_INTCON_SIZE 0xFFF
 
@@ -101,6 +103,9 @@ static int modem_irq_init(void)
 	static struct irq_chip  modem_irq_chip;
 	struct modem_irq *mi;
 
+	if (!cpu_is_u5500())
+		return -ENODEV;
+
 	pr_info("modem_irq: Set up IRQ handler for incoming modem IRQ %d\n",
 		   IRQ_DB5500_MODEM);
 
-- 
1.7.2.dirty
