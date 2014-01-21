From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 21 Jan 2014 16:22:21 -0500
Subject: [PATCH 18/73] arm: fix implicit #include <linux/init.h> in entry asm.
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1390339396-3479-19-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They use the "_INIT" macro and friends, and hence need to
source this header file, vs. relying on getting it implicitly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/kernel/entry-armv.S | 2 ++
 arch/arm/vfp/entry.S         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b3fb8c9..ffc1c74 100644
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
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 46e1749..ec7ea24 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -8,6 +8,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/init.h>
+
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
 #include "../kernel/entry-header.S"
-- 
1.8.4.1
