From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 27 Jan 2016 12:27:45 +0800
Subject: [PATCH 08/15] nios2: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1453868872-26300-9-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/nios2/platform/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/nios2/platform/platform.c b/arch/nios2/platform/platform.c
index d478773..c62279c 100644
--- a/arch/nios2/platform/platform.c
+++ b/arch/nios2/platform/platform.c
@@ -39,8 +39,7 @@ static int __init nios2_soc_device_init(void)
 		}
 	}
 
-	return of_platform_populate(NULL, of_default_bus_match_table,
-		NULL, NULL);
+	return of_platform_default_populate(NULL, NULL, NULL);
 }
 
 device_initcall(nios2_soc_device_init);
-- 
2.6.0.GIT
