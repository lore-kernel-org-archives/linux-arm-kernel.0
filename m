From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:32 +0800
Subject: [PATCH v2 all 03/14] mips: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Tested-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/mips/ath79/setup.c           | 2 +-
 arch/mips/jz4740/setup.c          | 2 +-
 arch/mips/mti-sead3/sead3-setup.c | 2 +-
 arch/mips/pic32/pic32mzda/init.c  | 3 +--
 arch/mips/pistachio/init.c        | 2 +-
 arch/mips/xilfpga/init.c          | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index be451ee4a..51deb50 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -248,7 +248,7 @@ void __init plat_time_init(void)
 
 static int __init ath79_setup(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	if  (mips_machtype == ATH79_MACH_GENERIC_OF)
 		return 0;
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 510fc0d..d175c74 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -76,7 +76,7 @@ void __init device_tree_init(void)
 
 static int __init populate_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	return 0;
 }
 arch_initcall(populate_machine);
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index e43f480..bc73f32 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -105,7 +105,7 @@ void __init device_tree_init(void)
 
 static int __init customize_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	return 0;
 }
 arch_initcall(customize_machine);
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
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 96ba2cc..0bc25e3 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -128,7 +128,7 @@ static int __init plat_of_setup(void)
 	if (!of_have_populated_dt())
 		panic("Device tree not present");
 
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+	if (of_platform_default_populate(NULL, NULL, NULL))
 		panic("Failed to populate DT");
 
 	return 0;
diff --git a/arch/mips/xilfpga/init.c b/arch/mips/xilfpga/init.c
index ce2aee2..a97382f 100644
--- a/arch/mips/xilfpga/init.c
+++ b/arch/mips/xilfpga/init.c
@@ -49,7 +49,7 @@ static int __init plat_of_setup(void)
 	if (!of_have_populated_dt())
 		panic("Device tree not present");
 
-	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
+	if (of_platform_default_populate(NULL, NULL, NULL))
 		panic("Failed to populate DT");
 
 	return 0;
-- 
2.6.0.GIT
