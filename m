From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 May 2017 19:25:01 +0100
Subject: [RFC PATCH v3 4/4] arm64: neon: Add backwards compatibility
 kernel_neon_begin_partial()
In-Reply-To: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1495736721-20985-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel_neon_begin_partial() is no longer available, but the
implementation of kernel_neon_begin() should be sufficient to
satisfy kernel_neon_begin_partial() callers.

Because of the changed semantics of may_use_simd() and
kernel_neon_begin() such code really needs to be ported.

In the meantime, this patch restores buildability of kernel-mode
NEON client code.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/neon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
index fb9d137..885f7a6 100644
--- a/arch/arm64/include/asm/neon.h
+++ b/arch/arm64/include/asm/neon.h
@@ -19,4 +19,7 @@
 void kernel_neon_begin(void);
 void kernel_neon_end(void);
 
+/* FIXME: Backwards compatibility only, should go away: */
+#define kernel_neon_begin_partial(num_regs) kernel_neon_begin()
+
 #endif /* ! __ASM_NEON_H */
-- 
2.1.4
