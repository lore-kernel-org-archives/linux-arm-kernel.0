From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 2 Jul 2015 10:14:48 +0800
Subject: [PATCH v2] arm64: cpuidle: add __init section marker to
 arm_cpuidle_init
Message-ID: <1435803288-1478-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not needed after booting, this patch moves the arm_cpuidle_init()
function to the __init section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/include/asm/cpuidle.h | 2 +-
 arch/arm64/kernel/cpuidle.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 0f74f05..5748d3b 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,7 +4,7 @@
 #include <asm/proc-fns.h>
 
 #ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
+extern int __init arm_cpuidle_init(unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
 #else
 static inline int arm_cpuidle_init(unsigned int cpu)
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
