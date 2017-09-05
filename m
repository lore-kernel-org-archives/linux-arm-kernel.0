From: cj.chengjian@huawei.com (chengjian c00427203)
Date: Tue, 5 Sep 2017 10:28:38 +0800
Subject: [PATCH] arm64: Convert pr_warning to standard pr_warn
Message-ID: <1504578518-77544-1-git-send-email-cj.chengjian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert pr_warning to standard pr_warn in arch/arm64/kernel/smp.c

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a..efcaa05 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -972,7 +972,7 @@ void smp_send_stop(void)
 		udelay(1);
 
 	if (num_online_cpus() > 1)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(cpu_online_mask));
 }
 
@@ -1009,7 +1009,7 @@ void crash_smp_send_stop(void)
 		udelay(1);
 
 	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(&mask));
 }
 
-- 
1.8.3.1
