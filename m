From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Dec 2017 12:26:45 +0000
Subject: [PATCH v2 19/19] DO NOT MERGE
In-Reply-To: <20171204122645.31535-1-ard.biesheuvel@linaro.org>
References: <20171204122645.31535-1-ard.biesheuvel@linaro.org>
Message-ID: <20171204122645.31535-20-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test code to force a kernel_neon_end+begin sequence at every yield point,
and wipe the entire NEON state before resuming the algorithm.
---
 arch/arm64/include/asm/assembler.h | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 917b026d3e00..dfee20246592 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -549,6 +549,7 @@ alternative_else_nop_endif
 	cmp		w1, #1 // == PREEMPT_OFFSET
 	csel		x0, x0, xzr, eq
 	tbnz		x0, #TIF_NEED_RESCHED, 5555f	// needs rescheduling?
+	b		5555f
 4444:
 #endif
 	.subsection	1
@@ -558,6 +559,38 @@ alternative_else_nop_endif
 	.macro		yield_neon_post, lbl:req
 	bl		kernel_neon_end
 	bl		kernel_neon_begin
+	movi		v0.16b, #0x55
+	movi		v1.16b, #0x55
+	movi		v2.16b, #0x55
+	movi		v3.16b, #0x55
+	movi		v4.16b, #0x55
+	movi		v5.16b, #0x55
+	movi		v6.16b, #0x55
+	movi		v7.16b, #0x55
+	movi		v8.16b, #0x55
+	movi		v9.16b, #0x55
+	movi		v10.16b, #0x55
+	movi		v11.16b, #0x55
+	movi		v12.16b, #0x55
+	movi		v13.16b, #0x55
+	movi		v14.16b, #0x55
+	movi		v15.16b, #0x55
+	movi		v16.16b, #0x55
+	movi		v17.16b, #0x55
+	movi		v18.16b, #0x55
+	movi		v19.16b, #0x55
+	movi		v20.16b, #0x55
+	movi		v21.16b, #0x55
+	movi		v22.16b, #0x55
+	movi		v23.16b, #0x55
+	movi		v24.16b, #0x55
+	movi		v25.16b, #0x55
+	movi		v26.16b, #0x55
+	movi		v27.16b, #0x55
+	movi		v28.16b, #0x55
+	movi		v29.16b, #0x55
+	movi		v30.16b, #0x55
+	movi		v31.16b, #0x55
 	b		\lbl
 	.previous
 	.endm
-- 
2.11.0
