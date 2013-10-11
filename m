From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:15 +0100
Subject: [PATCH 09/14] arm64: asm: add CPU_LE & CPU_BE assembler helpers
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-10-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU_LE and CPU_BE to select assembler code in little and big
endian configurations respectively.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/include/asm/assembler.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 381b935..fd3e392 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -115,6 +115,25 @@ lr	.req	x30		// link register
 	.align	7
 	b	\label
 	.endm
+
+/*
+ * Select code when configured for BE.
+ */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define CPU_BE(code...) code
+#else
+#define CPU_BE(code...)
+#endif
+
+/*
+ * Select code when configured for LE.
+ */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define CPU_LE(code...)
+#else
+#define CPU_LE(code...) code
+#endif
+
 /*
  * Define a macro that constructs a 64-bit value by concatenating two
  * 32-bit registers. Note that on big endian systems the order of the
-- 
1.7.9.5
