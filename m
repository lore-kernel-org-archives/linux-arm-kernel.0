From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Jan 2015 12:29:44 +0000
Subject: [PATCH] arm64: dump: Fix implicit inclusion of definition for
 PCI_IOBASE
Message-ID: <1421065784-31708-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since c9465b4ec37a68425 (arm64: add support to dump the kernel page tables)
allmodconfig has failed to build on arm64 as a result of:

../arch/arm64/mm/dump.c:55:20: error: 'PCI_IOBASE' undeclared here (not in a function)

Fix this by explicitly including io.h to ensure that a definition is
present.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index cf33f33333cc..258ce731c5cd 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -14,6 +14,7 @@
  * of the License.
  */
 #include <linux/debugfs.h>
+#include <linux/io.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
-- 
2.1.4
