From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:30 +0800
Subject: [PATCH v3 02/14] arm64: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9dc6776..5b377bb 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -366,8 +366,7 @@ static int __init arm64_device_init(void)
 {
 	if (of_have_populated_dt()) {
 		of_iommu_init();
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     NULL, NULL);
+		of_platform_default_populate(NULL, NULL, NULL);
 	} else if (acpi_disabled) {
 		pr_crit("Device tree not populated\n");
 	}
-- 
2.6.0.GIT
