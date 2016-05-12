From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:10 +0800
Subject: [PATCH v4 13/18] mips: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-14-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/mips/pic32/pic32mzda/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 775ff90..77ecf32 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -147,8 +147,7 @@ static int __init plat_of_setup(void)
 		panic("Device tree not present");
 
 	pic32_of_prepare_platform_data(pic32_auxdata_lookup);
-	if (of_platform_populate(NULL, of_default_bus_match_table,
-				 pic32_auxdata_lookup, NULL))
+	if (of_platform_default_populate(NULL, pic32_auxdata_lookup, NULL))
 		panic("Failed to populate DT");
 
 	return 0;
-- 
1.7.12.4
