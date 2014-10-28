From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Mon, 27 Oct 2014 18:29:30 -0700
Subject: [PATCH] ARM: Clarify do_div() usage
Message-ID: <1414459770-31592-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment above do_div() makes it look like the first argument is
supposed to be a pointer to the dividend, so add a note to explain
further.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/include/asm/div64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 662c7bd..993489f 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -14,6 +14,9 @@
  * 	return remainder;
  * }
  *
+ * Note that "*n" does not mean the first argument should be a
+ * pointer, but rather indicates that the value is modified in-place.
+ *
  * In other words, a 64-bit dividend with a 32-bit divisor producing
  * a 64-bit result and a 32-bit remainder.  To accomplish this optimally
  * we call a special __do_div64 helper with completely non standard
-- 
1.9.1
