From: leochen@broadcom.com (Leo Chen)
Date: Wed, 7 Oct 2009 11:41:46 -0700
Subject: [PATCH] bcmring: add reg32_clear_bits and reg32_set_bits functions
Message-ID: <mailman.61.1255122467.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix checkpatch errors in reg.h for reg32 accessors

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/include/csp/reg.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/include/csp/reg.h b/arch/arm/mach-bcmring/include/csp/reg.h
index e5f60bf..945dde2 100644
--- a/arch/arm/mach-bcmring/include/csp/reg.h
+++ b/arch/arm/mach-bcmring/include/csp/reg.h
@@ -84,6 +84,20 @@
 
 #endif
 
+static inline void reg32_clear_bits(volatile uint32_t *reg, uint32_t value)
+{
+	REG_LOCAL_IRQ_SAVE;
+	*reg &= ~(value);
+	REG_LOCAL_IRQ_RESTORE;
+}
+
+static inline void reg32_set_bits(volatile uint32_t *reg, uint32_t value)
+{
+	REG_LOCAL_IRQ_SAVE;
+	*reg |= value;
+	REG_LOCAL_IRQ_RESTORE;
+}
+
 static inline void reg32_modify_and(volatile uint32_t *reg, uint32_t value)
 {
 	REG_LOCAL_IRQ_SAVE;
-- 
1.6.0.6

Leo Chen
