From: zhongjiang@huawei.com (zhong jiang)
Date: Fri, 21 Sep 2018 20:20:09 +0800
Subject: [PATCH] drivers/firmware: Should be a struct size instead of a
 pointer.
Message-ID: <1537532409-43532-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kcalloc should be sizeof(*cpu_groups) instead of sizeof(cpu_groups).

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/firmware/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index 3469436..26afabc 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -162,7 +162,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
+	cpu_groups = kcalloc(nb_available_cpus, sizeof(*cpu_groups),
 			     GFP_KERNEL);
 	if (!cpu_groups)
 		return -ENOMEM;
-- 
1.7.12.4
