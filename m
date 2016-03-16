From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:36 +0800
Subject: [PATCH v2 all 07/14] cris: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-8-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/cris/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index bb12aa9..5ee5dfc 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -215,7 +215,7 @@ subsys_initcall(topology_init);
 
 static int __init cris_of_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	return 0;
 }
 core_initcall(cris_of_init);
-- 
2.6.0.GIT
