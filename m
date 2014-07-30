From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Jul 2014 20:23:14 +0100
Subject: [PATCH] irq: gic-v3: Tag all low level accessors __maybey_unused
Message-ID: <1406748194-21094-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

This is only really needed for gic_write_sgi1r in the !SMP case since it
is only referenced in the SMP initialisation code but it seems better to
have these functions all next to each other and declared consistently.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 41b98ba7ffd1..f1ba38f11f7a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -104,7 +104,7 @@ static void gic_redist_wait_for_rwp(void)
 }
 
 /* Low level accessors */
-static u64 gic_read_iar(void)
+static u64 __maybe_unused gic_read_iar(void)
 {
 	u64 irqstat;
 
@@ -112,24 +112,24 @@ static u64 gic_read_iar(void)
 	return irqstat;
 }
 
-static void gic_write_pmr(u64 val)
+static void __maybe_unused gic_write_pmr(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
 }
 
-static void gic_write_ctlr(u64 val)
+static void __maybe_unused gic_write_ctlr(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
 	isb();
 }
 
-static void gic_write_grpen1(u64 val)
+static void __maybe_unused gic_write_grpen1(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
 	isb();
 }
 
-static void gic_write_sgi1r(u64 val)
+static void __maybe_unused gic_write_sgi1r(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
 }
-- 
2.0.1
