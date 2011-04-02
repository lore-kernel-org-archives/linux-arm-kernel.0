From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Sat,  2 Apr 2011 15:13:00 +0530
Subject: [PATCH v18 07/13] davinci: move DM64XX_VDD3P3V_PWDN to devices.c
Message-ID: <1301737380-4288-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of DM64XX_VDD3P3V_PWDN from hardware.h
to devices.c since it is used only there.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/devices.c               |    1 +
 arch/arm/mach-davinci/include/mach/hardware.h |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 22ebc64..4e1b663 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -182,6 +182,7 @@ static struct platform_device davinci_mmcsd1_device = {
 	.resource = mmcsd1_resources,
 };
 
+#define DM64XX_VDD3P3V_PWDN	0x48
 
 void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 {
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index c45ba1f..414e0b9 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -21,9 +21,6 @@
  */
 #define DAVINCI_SYSTEM_MODULE_BASE        0x01C40000
 
-/* System control register offsets */
-#define DM64XX_VDD3P3V_PWDN	0x48
-
 /*
  * I/O mapping
  */
-- 
1.6.2.4
