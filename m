From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Feb 2011 10:21:09 +0100
Subject: [PATCH 3/3] ARM: mx3/mx31ads: fix comments of irq callbacks
In-Reply-To: <20110211081050.GD27982@pengutronix.de>
References: <20110211081050.GD27982@pengutronix.de>
Message-ID: <1297416069-6861-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arguments to these callbacks were changed in

	e981a30 (ARM: mx3: irq_data conversion.)

but the comments were not adapted.

Cc: Lennert Buytenhek <buytenh@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31ads.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 14e7671..4e4b780 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -144,7 +144,7 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
 
 /*
  * Disable an expio pin's interrupt by setting the bit in the imr.
- * @param irq           an expio virtual irq number
+ * @param d	an expio virtual irq description
  */
 static void expio_mask_irq(struct irq_data *d)
 {
@@ -156,7 +156,7 @@ static void expio_mask_irq(struct irq_data *d)
 
 /*
  * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
- * @param irq           an expanded io virtual irq number
+ * @param d	an expio virtual irq description
  */
 static void expio_ack_irq(struct irq_data *d)
 {
@@ -167,7 +167,7 @@ static void expio_ack_irq(struct irq_data *d)
 
 /*
  * Enable a expio pin's interrupt by clearing the bit in the imr.
- * @param irq           a expio virtual irq number
+ * @param d	an expio virtual irq description
  */
 static void expio_unmask_irq(struct irq_data *d)
 {
-- 
1.7.2.3
