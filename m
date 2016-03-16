From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:34 +0800
Subject: [PATCH v2 all 05/14] c6x: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-6-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Mark Salter <msalter@redhat.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/c6x/platforms/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/c6x/platforms/platform.c b/arch/c6x/platforms/platform.c
index 26c1a35..8412334 100644
--- a/arch/c6x/platforms/platform.c
+++ b/arch/c6x/platforms/platform.c
@@ -11,7 +11,7 @@
 
 static int __init c6x_device_probe(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	return 0;
 }
 core_initcall(c6x_device_probe);
-- 
2.6.0.GIT
