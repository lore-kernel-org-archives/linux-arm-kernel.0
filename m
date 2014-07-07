From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:48 +0200
Subject: [PATCH v2 23/30] ARM: shmobile: armadillo800eva-reference: Initialise
 CMT1 device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-24-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise CMT1 device using DT when booting armadillo800eva
using DT-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c                  | 11 +----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c430197..346f6ef 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -205,6 +205,10 @@
 	};
 };
 
+&cmt1 {
+	status = "okay";
+};
+
 &tmu0 {
 	status = "okay";
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 3d5eaca..3dcdc8d 100644
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
@@ -325,6 +321,7 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
+	&cmt1_device,
 	&irqpin0_device,
 	&irqpin1_device,
 	&irqpin2_device,
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
2.0.0.rc2
