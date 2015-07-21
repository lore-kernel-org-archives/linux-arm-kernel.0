From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Jul 2015 15:48:44 +0900
Subject: [PATCH] ARM: refactor bitops functions with BIT_MASK() and BIT_WORD()
Message-ID: <1437461324-7284-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use BIT_MASK() and BIT_WORD() rather than hard-coding the size
of the "long" type.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/bitops.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 5638099..e943e6c 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -35,9 +35,9 @@
 static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	*p |= mask;
@@ -47,9 +47,9 @@ static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *
 static inline void ____atomic_clear_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	*p &= ~mask;
@@ -59,9 +59,9 @@ static inline void ____atomic_clear_bit(unsigned int bit, volatile unsigned long
 static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	*p ^= mask;
@@ -73,9 +73,9 @@ ____atomic_test_and_set_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
 	unsigned int res;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	res = *p;
@@ -90,9 +90,9 @@ ____atomic_test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
 	unsigned int res;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	res = *p;
@@ -107,9 +107,9 @@ ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
 {
 	unsigned long flags;
 	unsigned int res;
-	unsigned long mask = 1UL << (bit & 31);
+	unsigned long mask = BIT_MASK(bit);
 
-	p += bit >> 5;
+	p += BIT_WORD(bit);
 
 	raw_local_irq_save(flags);
 	res = *p;
-- 
1.9.1
