From: Claudio.Fontana@huawei.com (Claudio Fontana)
Date: Thu, 08 Nov 2012 11:39:05 +0100
Subject: [PATCH] ARM: plat-versatile: move secondary CPU startup code out of
 .init for hotplug
Message-ID: <509B8BC9.4070209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Using __CPUINIT instead of __INIT puts the secondary CPU startup code
into the "right" section: it will not be freed in hotplug configurations,
allowing hot-add of cpus, while still getting freed in non-hotplug configs.

Signed-off-by: Claudio Fontana <claudio.fontana@huawei.com>
---
 arch/arm/plat-versatile/headsmp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index dd703ef..19fe180 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
+	__CPUINIT
 
 /*
  * Realview/Versatile Express specific entry point for secondary CPUs.
-- 
1.7.12.1
