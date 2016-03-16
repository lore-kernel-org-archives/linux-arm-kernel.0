From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:35 +0800
Subject: [PATCH v2 all 06/14] metag: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-7-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: James Hogan <james.hogan@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/metag/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/metag/kernel/setup.c b/arch/metag/kernel/setup.c
index 31cf53d..c88f937 100644
--- a/arch/metag/kernel/setup.c
+++ b/arch/metag/kernel/setup.c
@@ -415,8 +415,7 @@ static int __init customize_machine(void)
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 	else
-		of_platform_populate(NULL, of_default_bus_match_table, NULL,
-				     NULL);
+		of_platform_default_populate(NULL, NULL, NULL);
 	return 0;
 }
 arch_initcall(customize_machine);
-- 
2.6.0.GIT
