From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 29 Jun 2017 14:46:39 +0530
Subject: [PATCH] ARM: sa1111 : constify dev_pm_ops structures.
Message-ID: <5795d1a3b6f84f073a0a731ec5b75a93c56a3918.1498724604.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/common/sa1111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 4ecd512..09193b2 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1112,7 +1112,7 @@ static int sa1111_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct dev_pm_ops sa1111_pm_ops = {
+static const struct dev_pm_ops sa1111_pm_ops = {
 	.suspend_noirq = sa1111_suspend_noirq,
 	.resume_noirq = sa1111_resume_noirq,
 };
-- 
1.9.1
