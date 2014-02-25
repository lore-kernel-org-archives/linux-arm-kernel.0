From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 25 Feb 2014 18:23:16 +0900
Subject: [PATCH v4 7/7] arm64: add __ASSEMBLY__ in asm/insn.h
In-Reply-To: <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391768336-5642-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393320196-2942-8-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since insn.h is indirectly included in asm/entry-ftrace.S,
we need to exclude some declarations by __ASSEMBLY__.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/insn.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index c44ad39..dc1f73b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -21,6 +21,7 @@
 /* A64 instructions are always 32 bits. */
 #define	AARCH64_INSN_SIZE		4
 
+#ifndef __ASSEMBLY__
 /*
  * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
  * Section C3.1 "A64 instruction index by encoding":
@@ -104,5 +105,6 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
+#endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
-- 
1.7.9.5
