From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:53 +0200
Subject: [PATCH 4/9] ARM: S5PV210: add support for device-table on Aquila&Goni
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial, empty device-table arrays, they will be populated later.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |    4 ++++
 arch/arm/mach-s5pv210/mach-goni.c   |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index e412664..7989932 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -488,6 +488,9 @@ static struct platform_device *aquila_devices[] __initdata = {
 	&s5p_device_fimc2,
 };
 
+static struct s3c_devtable aquila_devtable[] __initdata = {
+};
+
 static void __init aquila_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -512,6 +515,7 @@ static void __init aquila_machine_init(void)
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
+	samsung_add_devices(aquila_devtable, ARRAY_SIZE(aquila_devtable));
 }
 
 MACHINE_START(AQUILA, "Aquila")
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 53754d7..6f555cf 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -467,6 +467,9 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 };
 
+static struct s3c_devtable goni_devtable[] __initdata = {
+};
+
 static void __init goni_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -487,6 +490,7 @@ static void __init goni_machine_init(void)
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
+	samsung_add_devices(goni_devtable, ARRAY_SIZE(goni_devtable));
 }
 
 MACHINE_START(GONI, "GONI")
-- 
1.7.1.569.g6f426
