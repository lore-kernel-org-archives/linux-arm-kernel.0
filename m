From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:57:08 +0900
Subject: [PATCH v3 3/3] ARM: shmobile: kzm9g-reference: Enable CMT1 in device
 tree
In-Reply-To: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
References: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410137828-4769-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* No change
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
 arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 477f815..30ef97e 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -173,6 +173,10 @@
 	};
 };
 
+&cmt1 {
+	status = "ok";
+};
+
 &i2c0 {
 	status = "okay";
 	as3711 at 40 {
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 0085305..b7bd8e5 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -697,10 +697,6 @@ static struct platform_device irqpin3_device = {
 	},
 };
 
-static struct platform_device *sh73a0_devices_dt[] __initdata = {
-	&cmt1_device,
-};
-
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -713,6 +709,7 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif8_device,
 	&tmu0_device,
 	&ipmmu_device,
+	&cmt1_device,
 };
 
 static struct platform_device *sh73a0_late_devices[] __initdata = {
@@ -737,8 +734,6 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
-	platform_add_devices(sh73a0_devices_dt,
-			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -763,8 +758,6 @@ void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
-	early_platform_add_devices(sh73a0_devices_dt,
-				   ARRAY_SIZE(sh73a0_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -779,8 +772,6 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
-	platform_add_devices(sh73a0_devices_dt,
-			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.0.1
