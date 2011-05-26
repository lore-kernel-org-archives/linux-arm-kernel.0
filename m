From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 26 May 2011 13:40:22 +0900
Subject: [PATCH] arm: exynos4: address a section mismatch w/ suspend issue.
Message-ID: <1306384822-17651-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The section mismatch in headsmp.S made hotplug stop working after the
first instance of suspend-to-RAM and its wakeup.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/headsmp.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/headsmp.S b/arch/arm/mach-exynos4/headsmp.S
index 6c6cfc5..3cdeb36 100644
--- a/arch/arm/mach-exynos4/headsmp.S
+++ b/arch/arm/mach-exynos4/headsmp.S
@@ -13,7 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
+	__CPUINIT
 
 /*
  * exynos4 specific entry point for secondary CPUs.  This provides
-- 
1.7.4.1
