From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jan 2011 10:10:31 +0000
Subject: [PATCH 7/8] ARM: aaec2000: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
References: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1296468632-30743-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Bellido <ml@acolin.be>
---
 arch/arm/mach-aaec2000/core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
index f8465bd..de549bd 100644
--- a/arch/arm/mach-aaec2000/core.c
+++ b/arch/arm/mach-aaec2000/core.c
@@ -21,12 +21,12 @@
 #include <linux/signal.h>
 #include <linux/clk.h>
 #include <linux/gfp.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/sizes.h>
 
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
@@ -260,8 +260,7 @@ void __init aaec2000_set_clcd_plat_data(struct aaec2000_clcd_info *clcd)
 	memcpy(&mach_clcd_panel, &clcd->panel, sizeof(struct clcd_panel));
 }
 
-static struct flash_platform_data aaec2000_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data aaec2000_flash_data = {
 	.width		= 4,
 };
 
@@ -272,7 +271,7 @@ static struct resource aaec2000_flash_resource = {
 };
 
 static struct platform_device aaec2000_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &aaec2000_flash_data,
-- 
1.7.0.4
