From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:37 +0800
Subject: [PATCH v3 09/14] sh: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-10-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/boards/of-generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index bf3a166..a285ec9 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -186,8 +186,7 @@ static int __init sh_of_device_init(void)
 	pr_info("SH generic board support: populating platform devices\n");
 	if (of_have_populated_dt()) {
 		of_iommu_init();
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     NULL, NULL);
+		of_platform_default_populate(NULL, NULL, NULL);
 	} else {
 		pr_crit("Device tree not populated\n");
 	}
-- 
2.6.0.GIT
