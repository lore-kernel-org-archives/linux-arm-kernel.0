From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 28 May 2010 15:41:29 +0900
Subject: [PATCH 2/2] ARM: S5PV210: Add OneNAND device to the Aquila board
Message-ID: <4BFF6599.2080700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support OneNAND device to the Aquila board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    1 +
 arch/arm/mach-s5pv210/mach-aquila.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index d0432c6..7e2e1eb 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -51,6 +51,7 @@ config MACH_AQUILA
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
 	select S3C_DEV_FB
+	select S5PC110_DEV_ONENAND
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..fb9dbb2 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -118,6 +118,7 @@ static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
 
 static struct platform_device *aquila_devices[] __initdata = {
 	&s3c_device_fb,
+	&s5pc110_device_onenand,
 };
 
 static void __init aquila_map_io(void)
-- 
1.7.0.4
