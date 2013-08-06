From: minipli@googlemail.com (Mathias Krause)
Date: Tue,  6 Aug 2013 23:34:35 +0200
Subject: [PATCH] ARM: fix typo in is_gate_vma() macro
Message-ID: <1375824875-1934-1-git-send-email-minipli@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a5463cd3 "ARM: make vectors page inaccessible from userspace"
introduced a typo making arch_vma_name() always return "[vectors]".
Fix up that regression (of the hush-hush security fix).

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/arm/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 16ed3f7..34fe52d 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -462,7 +462,7 @@ int in_gate_area_no_mm(unsigned long addr)
 {
 	return in_gate_area(NULL, addr);
 }
-#define is_gate_vma(vma)	((vma) = &gate_vma)
+#define is_gate_vma(vma)	((vma) == &gate_vma)
 #else
 #define is_gate_vma(vma)	0
 #endif
-- 
1.7.10.4
