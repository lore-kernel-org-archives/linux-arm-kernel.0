From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Aug 2014 11:52:46 +0900
Subject: [PATCH repost 2/5] ARM: shmobile: armadillo800eva-reference: Enable
 CMT1 in device tree
In-Reply-To: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
References: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1407725569-31413-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work by Magnus Damm

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c                  | 11 +----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 266c439..5e646e6 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -191,6 +191,10 @@
 	renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
 };
 
+&cmt1 {
+	status = "ok";
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen at 55 {
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 3d5eaca..dc44a44 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -311,10 +311,6 @@ static struct platform_device ipmmu_device = {
 	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 };
 
-static struct platform_device *r8a7740_devices_dt[] __initdata = {
-	&cmt1_device,
-};
-
 static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -331,6 +327,7 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&irqpin3_device,
 	&tmu0_device,
 	&ipmmu_device,
+	&cmt1_device,
 };
 
 /* DMA */
@@ -756,8 +753,6 @@ void __init r8a7740_add_standard_devices(void)
 	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
-	platform_add_devices(r8a7740_devices_dt,
-			    ARRAY_SIZE(r8a7740_devices_dt));
 	platform_add_devices(r8a7740_late_devices,
 			     ARRAY_SIZE(r8a7740_late_devices));
 
@@ -779,8 +774,6 @@ void __init r8a7740_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7740_early_devices,
 				   ARRAY_SIZE(r8a7740_early_devices));
-	early_platform_add_devices(r8a7740_devices_dt,
-				   ARRAY_SIZE(r8a7740_devices_dt));
 
 	/* setup early console here as well */
 	shmobile_setup_console();
@@ -790,8 +783,6 @@ void __init r8a7740_add_early_devices(void)
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
-	platform_add_devices(r8a7740_devices_dt,
-			    ARRAY_SIZE(r8a7740_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.0.1
