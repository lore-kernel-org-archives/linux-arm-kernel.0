From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:14:27 +0800
Subject: [PATCH 2/3] arm64: fix the wrong type
In-Reply-To: <1464574468-22700-1-git-send-email-shijie.huang@arm.com>
References: <1464574468-22700-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464574468-22700-2-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use the pudval_t for the PUD_* macros, not the pgdval_t.
This patch fixes them.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eeb3269..54e2fbf 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -116,9 +116,9 @@
  * Level 1 descriptor (PUD).
  */
 #define PUD_TYPE_TABLE		(_AT(pudval_t, 3) << 0)
-#define PUD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
-#define PUD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
-#define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
+#define PUD_TABLE_BIT		(_AT(pudval_t, 1) << 1)
+#define PUD_TYPE_MASK		(_AT(pudval_t, 3) << 0)
+#define PUD_TYPE_SECT		(_AT(pudval_t, 1) << 0)
 
 /*
  * Level 2 descriptor (PMD).
-- 
2.5.5
