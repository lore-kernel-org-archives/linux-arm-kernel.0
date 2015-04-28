From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 28 Apr 2015 18:17:25 +0200
Subject: [PATCH] arm: remove comments on CPU_ARM1020_CPU_IDLE
Message-ID: <1430237845-14714-1-git-send-email-valentinrothberg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_ARM1020_CPU_IDLE is not defined in Kconfig.  The last reference on
LKML dates back to 2001, so we can safely remove the comments to make
static analysis tools happy.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I detected this issue with scripts/checkkconfigsymbols.py
---
 arch/arm/mm/proc-arm1020.S  | 2 --
 arch/arm/mm/proc-arm1020e.S | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index aa0519eed698..774ef1323554 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -22,8 +22,6 @@
  *
  * These are the low level assembler for performing cache and TLB
  * functions on the arm1020.
- *
- *  CONFIG_CPU_ARM1020_CPU_IDLE -> nohlt
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index bff4c7f70fd6..ae3c27b71594 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -22,8 +22,6 @@
  *
  * These are the low level assembler for performing cache and TLB
  * functions on the arm1020e.
- *
- *  CONFIG_CPU_ARM1020_CPU_IDLE -> nohlt
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-- 
2.1.4
