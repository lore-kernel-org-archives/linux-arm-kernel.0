From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Jan 2015 20:52:10 +0000
Subject: [PATCH] arm64: dump: Fix implicit inclusion of definition for
 PCI_IOBASE
Message-ID: <1421959930-26466-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since c9465b4ec37a68425 (arm64: add support to dump the kernel page tables)
allmodconfig has failed to build on arm64 as a result of:

../arch/arm64/mm/dump.c:55:20: error: 'PCI_IOBASE' undeclared here (not in a function)

Fix this by explicitly including io.h to ensure that a definition is
present.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

As discussed the other day the quick stop gap for the implicit inclusion
issues that are breaking -next builds at the minute.

 arch/arm64/mm/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index cf33f33333cc..d54dc9ac4b70 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -15,6 +15,7 @@
  */
 #include <linux/debugfs.h>
 #include <linux/fs.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
-- 
2.1.4
