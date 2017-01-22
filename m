From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 22 Jan 2017 11:32:28 -0500
Subject: [PATCH 04/20] arm: migrate exception table users off module.h and
 onto extable.h
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Message-ID: <20170122163244.11740-5-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mm/extable.c | 2 +-
 arch/arm/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/extable.c b/arch/arm/mm/extable.c
index 312e15e6d00b..f436f7439e46 100644
--- a/arch/arm/mm/extable.c
+++ b/arch/arm/mm/extable.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mm/extable.c
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3a2e678b8d30..94de590db99e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
-- 
2.11.0
