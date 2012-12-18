From: Claudio.Fontana@huawei.com (Claudio Fontana)
Date: Tue, 18 Dec 2012 09:42:49 +0100
Subject: [PATCH RESEND 4] ARM: plat-versatile: move secondary CPU startup into
 cpuinit
In-Reply-To: <50B47C31.2040709@huawei.com>
References: <50B47C31.2040709@huawei.com>
Message-ID: <50D02C89.9030307@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Using __CPUINIT instead of __INIT puts the secondary CPU startup code
into the "right" section: it will not be freed in hotplug configurations,
allowing hot-add of cpus, while still getting freed in non-hotplug configs.

Tested successfully on Fast-Models and on Arndale for VCPU hotplug. 

Signed-off-by: Claudio Fontana <claudio.fontana@huawei.com>
Tested-by: Claudio Fontana <claudio.fontana@huawei.com>

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
