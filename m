From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 12 Jun 2014 17:23:18 +0530
Subject: [PATCH V2 10/19] irqchip: crossbar: DRA7: Fix unused crossbar list
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1402574007-13987-11-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

On DRA7 compatible IRQ crossbar, IRQ 10 default mapped to L3_APP_IRQ,
IRQ133 is default mapped to NMI pin, 139 and 140 crossbars are
unused(not routed). Mark these as unused crossbar IRQs.

Technical Reference Manual documentation update expected
DRA72x-TRMINC00067 is being used to track the update.

Reported-by: Nishanth Menon <nm@ti.com>
Reported-by: Sricharan R <r.sricharan@ti.com>
Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 7d4db07..42a2e62 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -253,8 +253,8 @@ err1:
 	return -ENOMEM;
 }
 
-/* irq number 10 cannot be used because of hw bug */
-static int dra_irqs_unused[] = { 10 };
+/* irq number 10,133,139 and 140 cannot be used because of hw bug */
+static int dra_irqs_unused[] = { 10 , 133, 139, 140 };
 static struct crossbar_data cb_dra_data = { dra_irqs_unused,
 				     ARRAY_SIZE(dra_irqs_unused), 0 };
 
-- 
1.7.9.5
