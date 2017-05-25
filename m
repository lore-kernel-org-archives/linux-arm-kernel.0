From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 May 2017 19:24:58 +0100
Subject: [RFC PATCH v3 1/4] arm64: neon: Add missing header guard in
 <asm/neon.h>
In-Reply-To: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1495736721-20985-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/neon.h doesn't have a header inclusion guard, but it should
have one for consistency with other headers.

This patch adds a suitable guard.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/neon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
index ad4cdc9..5368bd0 100644
--- a/arch/arm64/include/asm/neon.h
+++ b/arch/arm64/include/asm/neon.h
@@ -8,6 +8,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef __ASM_NEON_H
+#define __ASM_NEON_H
+
 #include <linux/types.h>
 #include <asm/fpsimd.h>
 
@@ -17,3 +20,5 @@
 
 void kernel_neon_begin_partial(u32 num_regs);
 void kernel_neon_end(void);
+
+#endif /* ! __ASM_NEON_H */
-- 
2.1.4
