From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:05 +0100
Subject: [PATCH 2/8] ARM: ux500: Rename references to the ccu9540 dev board
 accordingly
In-Reply-To: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
References: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351159031-25391-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enabling ST-Ericsson's ccu9540 development board the board's
full name has not been used. This patch adapts all references of
the board's short name to how it should be referenced.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/{u9540.dts => ccu9540.dts} |    4 ++--
 arch/arm/mach-ux500/cpu-db8500.c             |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/{u9540.dts => ccu9540.dts} (93%)

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/ccu9540.dts
similarity index 93%
rename from arch/arm/boot/dts/u9540.dts
rename to arch/arm/boot/dts/ccu9540.dts
index 95892ec..26dfe83 100644
--- a/arch/arm/boot/dts/u9540.dts
+++ b/arch/arm/boot/dts/ccu9540.dts
@@ -13,8 +13,8 @@
 /include/ "dbx5x0.dtsi"
 
 / {
-	model = "ST-Ericsson U9540 platform with Device Tree";
-	compatible = "st-ericsson,u9540";
+	model = "ST-Ericsson CCU9540 platform with Device Tree";
+	compatible = "st-ericsson,ccu9540";
 
 	memory {
 		reg = <0x00000000 0x20000000>;
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 0b15591..6e9a06d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -320,8 +320,8 @@ static void __init u8500_init_machine(void)
 		snowball_pinmaps_init();
 	else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
 		hrefv60_pinmaps_init();
-	else if (of_machine_is_compatible("st-ericsson,u9540")) {}
-		/* TODO: Add u9540 pinmaps. */
+	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
+		/* TODO: Add pinmaps for ccu9540 board. */
 
 	/* TODO: Export SoC, USB, cpu-freq and DMA40 */
 	parent = u8500_of_init_devices();
@@ -334,7 +334,7 @@ static const char * u8500_dt_board_compat[] = {
 	"calaosystems,snowball-a9500",
 	"st-ericsson,hrefv60+",
 	"st-ericsson,mop500",
-	"st-ericsson,u9540",
+	"st-ericsson,ccu9540",
 	NULL,
 };
 
-- 
1.7.9.5
