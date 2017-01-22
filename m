From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 22 Jan 2017 16:41:28 +0000
Subject: [PATCH -next] ARM: 8641/1: treewide: fix error return code in
 hip04_smp_init()
Message-ID: <20170122164128.29381-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -ENODEV from the of_find_compatible_node()
error handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/arm/mach-hisi/platmcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index a6c1176..f0fff21 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -279,6 +279,8 @@ static int __init hip04_smp_init(void)
 					 &hip04_boot_method[0], 4);
 	if (ret)
 		goto err;
+
+	ret = -ENODEV;
 	np_sctl = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
 	if (!np_sctl)
 		goto err;
