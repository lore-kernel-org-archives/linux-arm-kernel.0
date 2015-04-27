From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 27 Apr 2015 18:47:54 -0400
Subject: [PATCH 05/11] arm/mach-hisi: remove legacy __CPUINIT section that
 crept in
In-Reply-To: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1430174880-27958-6-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We removed __cpuinit support (leaving no-op stubs) quite some time ago.
However a new instance was added in commit 06cc5c1d4d7313bc864e9aac1d1cbd
("ARM: hisi: enable hix5hd2 SoC")

Since we want to clobber the stubs soon, get this removed now.
Note that there would normally be a corresponding removal of
a ".previous" directive, but in this case it appears that this
single function file was never paired off with one.

Cc: Haifeng Yan <yanhaifeng@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-hisi/headsmp.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
index 81e35b159e75..477da3966380 100644
--- a/arch/arm/mach-hisi/headsmp.S
+++ b/arch/arm/mach-hisi/headsmp.S
@@ -7,9 +7,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
-
-	__CPUINIT
 
 ENTRY(hisi_secondary_startup)
 	bl	v7_invalidate_l1
-- 
2.2.1
