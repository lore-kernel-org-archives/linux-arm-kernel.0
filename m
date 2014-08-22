From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:16 +0000
Subject: [PATCH 3/9] arm64: Remove unneeded extern keyword
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <1e9885b2581bae7e296b59411b26e03ba44a43e5.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function prototypes are never definitions, so remove any 'extern' keyword
from the funcion prototypes in cpu_ops.h. Fixes warnings emited by
checkpatch.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/cpu_ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index d7b4b38..150ce63 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -61,7 +61,7 @@ struct cpu_operations {
 };
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
-extern int __init cpu_read_ops(struct device_node *dn, int cpu);
-extern void __init cpu_read_bootcpu_ops(void);
+int __init cpu_read_ops(struct device_node *dn, int cpu);
+void __init cpu_read_bootcpu_ops(void);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
-- 
1.9.1
