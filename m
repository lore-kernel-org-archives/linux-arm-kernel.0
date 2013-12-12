From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:46 +0000
Subject: [PATCH 3/5] arm64: Fix include header order in vmlinux.lds.S
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <735546830af2105db3cbaccc0099a269a842de4e.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm-generic/vmlinux.lds.h should be included after the arch
specific headers so that the arch headers can override the
generic macro defs in asm-generic/vmlinux.lds.h.

Fixes preprosessor redefined warnings when adding arch specific
macros.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3072c41..6563b64 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -4,10 +4,10 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
 
-#include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #define ARM_EXIT_KEEP(x)
 #define ARM_EXIT_DISCARD(x)	x
-- 
1.8.1.2
