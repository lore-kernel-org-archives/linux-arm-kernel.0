From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 21 Aug 2013 17:50:17 +0800
Subject: [PATCH] ARM64: include: asm: include "asm/types.h" in
 "pgtable-2level-types.h" and "pgtable-3level-types.h"
Message-ID: <52148D59.5090603@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need include "asm/types.h", just like arm has done, or can not pass
compiling, the related error:

  In file included from arch/arm64/include/asm/page.h:37:0,
                   from drivers/staging/lustre/include/linux/lnet/linux/lib-lnet.h:42,
                   from drivers/staging/lustre/include/linux/lnet/lib-lnet.h:44,
                   from drivers/staging/lustre/lnet/lnet/api-ni.c:38:
  arch/arm64/include/asm/pgtable-2level-types.h:19:1: error: unknown type name ?u64
  arch/arm64/include/asm/pgtable-2level-types.h:20:1: error: unknown type name ?u64?

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/pgtable-2level-types.h |    2 ++
 arch/arm64/include/asm/pgtable-3level-types.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-2level-types.h b/arch/arm64/include/asm/pgtable-2level-types.h
index 3c3ca7d..5f101e6 100644
--- a/arch/arm64/include/asm/pgtable-2level-types.h
+++ b/arch/arm64/include/asm/pgtable-2level-types.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_PGTABLE_2LEVEL_TYPES_H
 #define __ASM_PGTABLE_2LEVEL_TYPES_H
 
+#include <asm/types.h>
+
 typedef u64 pteval_t;
 typedef u64 pgdval_t;
 typedef pgdval_t pmdval_t;
diff --git a/arch/arm64/include/asm/pgtable-3level-types.h b/arch/arm64/include/asm/pgtable-3level-types.h
index 4489615..4e94424 100644
--- a/arch/arm64/include/asm/pgtable-3level-types.h
+++ b/arch/arm64/include/asm/pgtable-3level-types.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_PGTABLE_3LEVEL_TYPES_H
 #define __ASM_PGTABLE_3LEVEL_TYPES_H
 
+#include <asm/types.h>
+
 typedef u64 pteval_t;
 typedef u64 pmdval_t;
 typedef u64 pgdval_t;
-- 
1.7.7.6
