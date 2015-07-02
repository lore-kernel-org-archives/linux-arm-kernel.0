From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 2 Jul 2015 09:33:07 +0800
Subject: [PATCH] arm64: cpuidle: add __init section marker to arm_cpuidle_init
Message-ID: <1435800787-696-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not needed after booting, this patch moves the arm_cpuidle_init()
function to the __init section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 7ce589c..9047cab6 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -15,7 +15,7 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int arm_cpuidle_init(unsigned int cpu)
+int __init arm_cpuidle_init(unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
-- 
2.1.4
