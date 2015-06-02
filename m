From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 2 Jun 2015 16:16:06 -0400
Subject: [PATCH 2/4] arm: fix implicit #include <linux/init.h> in entry asm.
In-Reply-To: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1433276168-21550-3-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They use the "_INIT" macro and friends, and hence need to
source this header file, vs. relying on getting it implicitly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/kernel/entry-armv.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 570306c49406..4942fab6ae28 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -15,6 +15,8 @@
  *  that causes it to save wrong values...  Be aware!
  */
 
+#include <linux/init.h>
+
 #include <asm/assembler.h>
 #include <asm/memory.h>
 #include <asm/glue-df.h>
-- 
2.2.1
