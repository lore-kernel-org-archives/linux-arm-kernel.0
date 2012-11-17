From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Nov 2012 17:57:16 +0400
Subject: [PATCH v3 10/18] ARM: clps711x: Unused empty "ACK" calls for
 IRQ-chips removed
In-Reply-To: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
Message-ID: <1353160644-22446-11-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index fcdcd91..e046439 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -66,10 +66,6 @@ static void int1_mask(struct irq_data *d)
 	clps_writel(intmr1, INTMR1);
 }
 
-static void int1_ack(struct irq_data *d)
-{
-}
-
 static void int1_eoi(struct irq_data *d)
 {
 	switch (d->irq) {
@@ -93,7 +89,6 @@ static void int1_unmask(struct irq_data *d)
 
 static struct irq_chip int1_chip = {
 	.name		= "Interrupt Vector 1",
-	.irq_ack	= int1_ack,
 	.irq_eoi	= int1_eoi,
 	.irq_mask	= int1_mask,
 	.irq_unmask	= int1_unmask,
@@ -108,10 +103,6 @@ static void int2_mask(struct irq_data *d)
 	clps_writel(intmr2, INTMR2);
 }
 
-static void int2_ack(struct irq_data *d)
-{
-}
-
 static void int2_eoi(struct irq_data *d)
 {
 	switch (d->irq) {
@@ -130,7 +121,6 @@ static void int2_unmask(struct irq_data *d)
 
 static struct irq_chip int2_chip = {
 	.name		= "Interrupt Vector 2",
-	.irq_ack	= int2_ack,
 	.irq_eoi	= int2_eoi,
 	.irq_mask	= int2_mask,
 	.irq_unmask	= int2_unmask,
-- 
1.7.8.6
