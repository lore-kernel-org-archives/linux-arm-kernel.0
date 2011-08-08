From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:31 +0100
Subject: [PATCH 11/12] ARM: mach-shmobile: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-12-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Paul Mundt <lethal@linux-sh.org>
CC: Magnus Damm <magnus.damm@gmail.com>
---
 arch/arm/mach-shmobile/include/mach/memory.h |    3 ---
 arch/arm/mach-shmobile/board-ag5evm.c        |    3 +++
 arch/arm/mach-shmobile/board-ap4evb.c        |    3 +++
 arch/arm/mach-shmobile/board-g3evm.c         |    3 +++
 arch/arm/mach-shmobile/board-g4evm.c         |    3 +++
 arch/arm/mach-shmobile/board-mackerel.c      |    3 +++
 6 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
index ad00c3c..0ffbe81 100644
--- a/arch/arm/mach-shmobile/include/mach/memory.h
+++ b/arch/arm/mach-shmobile/include/mach/memory.h
@@ -4,7 +4,4 @@
 #define PLAT_PHYS_OFFSET	UL(CONFIG_MEMORY_START)
 #define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
 
-/* DMA memory at 0xf6000000 - 0xffdfffff */
-#define CONSISTENT_DMA_SIZE (158 << 20)
-
 #endif /* __ASM_MACH_MEMORY_H */
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..167a67c 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -37,6 +37,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
+#include <linux/dma-mapping.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
@@ -446,6 +447,8 @@ static struct map_desc ag5evm_io_desc[] __initdata = {
 static void __init ag5evm_map_io(void)
 {
 	iotable_init(ag5evm_io_desc, ARRAY_SIZE(ag5evm_io_desc));
+	/* DMA memory at 0xf6000000 - 0xffdfffff */
+	init_consistent_dma_size(158 << 20);
 
 	/* setup early devices and console here as well */
 	sh73a0_add_early_devices();
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 9e0856b..ec8f9d9 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -42,6 +42,7 @@
 #include <linux/leds.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/dma-mapping.h>
 
 #include <media/sh_mobile_ceu.h>
 #include <media/sh_mobile_csi2.h>
@@ -1170,6 +1171,8 @@ static struct map_desc ap4evb_io_desc[] __initdata = {
 static void __init ap4evb_map_io(void)
 {
 	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
+	/* DMA memory at 0xf6000000 - 0xffdfffff */
+	init_consistent_dma_size(158 << 20);
 
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index ef4613b..8b620bf 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -32,6 +32,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/dma-mapping.h>
 #include <mach/sh7367.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -260,6 +261,8 @@ static struct map_desc g3evm_io_desc[] __initdata = {
 static void __init g3evm_map_io(void)
 {
 	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
+	/* DMA memory at 0xf6000000 - 0xffdfffff */
+	init_consistent_dma_size(158 << 20);
 
 	/* setup early devices and console here as well */
 	sh7367_add_early_devices();
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 8e3c555..7719ddc 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -33,6 +33,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
+#include <linux/dma-mapping.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -274,6 +275,8 @@ static struct map_desc g4evm_io_desc[] __initdata = {
 static void __init g4evm_map_io(void)
 {
 	iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
+	/* DMA memory at 0xf6000000 - 0xffdfffff */
+	init_consistent_dma_size(158 << 20);
 
 	/* setup early devices and console here as well */
 	sh7377_add_early_devices();
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d41c01f..671925d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -45,6 +45,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
+#include <linux/dma-mapping.h>
 
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
@@ -1377,6 +1378,8 @@ static struct map_desc mackerel_io_desc[] __initdata = {
 static void __init mackerel_map_io(void)
 {
 	iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
+	/* DMA memory at 0xf6000000 - 0xffdfffff */
+	init_consistent_dma_size(158 << 20);
 
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
-- 
1.7.2.5
