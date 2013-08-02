From: csd@broadcom.com (Christian Daudt)
Date: Fri, 2 Aug 2013 15:27:59 -0700
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
Message-ID: <1375482479-15732-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ this is a follow-up to this discussion:
http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
This patchset renames all uses of "bcm," name bindings to
"brcm," as they were done prior to knowing that brcm had
already been standardized as Broadcom vendor prefix
(in Documentation/devicetree/bindings/vendor-prefixes.txt).
This will not cause any churn on devices because none of
these bindings have made it into production yet.
Also rename the the following dt binding docs that had "bcm,"
in their name for consistency:
 - bcm,kona-sdhci.txt -> kona-sdhci.txt
 - bcm,kona-timer.txt -> kona-timer.txt

Changes since v1:
 - added driver match table entries for deprecated names

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
index fb7b5cd..cf1b206 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
@@ -6,4 +6,4 @@ bcm11351, bcm28145, bcm28155 SoCs) shall have the following properties:
 
 Required root node property:
 
-compatible = "bcm,bcm11351";
+compatible = "brcm,bcm11351";
diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
similarity index 87%
rename from Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
rename to Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
index 59fa6e6..a716952 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
@@ -4,14 +4,14 @@ This timer is used in the following Broadcom SoCs:
  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
 
 Required properties:
-- compatible : "bcm,kona-timer"
+- compatible : "brcm,kona-timer"
 - reg : Register range for the timer
 - interrupts : interrupt for the timer
 - clock-frequency: frequency that the clock operates
 
 Example:
 	timer at 35006000 {
-		compatible = "bcm,kona-timer";
+		compatible = "brcm,kona-timer";
 		reg = <0x35006000 0x1000>;
 		interrupts = <0x0 7 0x4>;
 		clock-frequency = <32768>;
diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 69ddf9f..f4aa37e 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -16,7 +16,7 @@ Required properties:
      performs the same operation).
 	"marvell,"aurora-outer-cache: Marvell Controller designed to be
 	 compatible with the ARM one with outer cache mode.
-	"bcm,bcm11351-a2-pl310-cache": For Broadcom bcm11351 chipset where an
+	"brcm,bcm11351-a2-pl310-cache": For Broadcom bcm11351 chipset where an
 	offset needs to be added to the address before passing down to the L2
 	cache controller
 - cache-unified : Specifies the cache is a unified cache.
diff --git a/Documentation/devicetree/bindings/misc/smc.txt b/Documentation/devicetree/bindings/misc/smc.txt
index 02b4281..8126821 100644
--- a/Documentation/devicetree/bindings/misc/smc.txt
+++ b/Documentation/devicetree/bindings/misc/smc.txt
@@ -4,11 +4,11 @@ This binding defines the location of the bounce buffer
 used for non-secure to secure communications.
 
 Required properties:
-- compatible : "bcm,kona-smc"
+- compatible : "brcm,kona-smc"
 - reg : Location and size of bounce buffer
 
 Example:
 	smc at 0x3404c000 {
-		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
+		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
 		reg = <0x3404c000 0x400>; //1 KiB in SRAM
 	};
diff --git a/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
similarity index 77%
rename from Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
rename to Documentation/devicetree/bindings/mmc/kona-sdhci.txt
index 094ae01..199d97a 100644
--- a/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
@@ -4,12 +4,12 @@ This file documents differences between the core properties in mmc.txt
 and the properties present in the bcm281xx SDHCI
 
 Required properties:
-- compatible : Should be "bcm,kona-sdhci"
+- compatible : Should be "brcm,kona-sdhci"
 
 Example:
 
 sdio2: sdio at 0x3f1a0000 {
-	compatible = "bcm,kona-sdhci";
+	compatible = "brcm,kona-sdhci";
 	reg = <0x3f1a0000 0x10000>;
 	interrupts = <0x0 74 0x4>;
 };
diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 67ec524..ed60a49 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "BCM11351 BRT board";
-	compatible = "bcm,bcm11351-brt", "bcm,bcm11351";
+	compatible = "brcm,bcm11351-brt", "brcm,bcm11351";
 
 	memory {
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 6bac38f..60168ff 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -18,7 +18,7 @@
 
 / {
 	model = "BCM11351 SoC";
-	compatible = "bcm,bcm11351";
+	compatible = "brcm,bcm11351";
 	interrupt-parent = <&gic>;
 
 	chosen {
@@ -35,12 +35,12 @@
 	};
 
 	smc at 0x3404c000 {
-		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
+		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
 		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
 
 	uart at 3e000000 {
-		compatible = "bcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
+		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		status = "disabled";
 		reg = <0x3e000000 0x1000>;
 		clock-frequency = <13000000>;
@@ -50,42 +50,42 @@
 	};
 
 	L2: l2-cache {
-		compatible = "bcm,bcm11351-a2-pl310-cache";
+		compatible = "brcm,bcm11351-a2-pl310-cache";
 		reg = <0x3ff20000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	timer at 35006000 {
-		compatible = "bcm,kona-timer";
+		compatible = "brcm,kona-timer";
 		reg = <0x35006000 0x1000>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <32768>;
 	};
 
 	sdio0: sdio at 0x3f180000 {
-		compatible = "bcm,kona-sdhci";
+		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
 		interrupts = <0x0 77 0x4>;
 		status = "disabled";
 	};
 
 	sdio1: sdio at 0x3f190000 {
-		compatible = "bcm,kona-sdhci";
+		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
 		interrupts = <0x0 76 0x4>;
 		status = "disabled";
 	};
 
 	sdio2: sdio at 0x3f1a0000 {
-		compatible = "bcm,kona-sdhci";
+		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
 		interrupts = <0x0 74 0x4>;
 		status = "disabled";
 	};
 
 	sdio3: sdio at 0x3f1b0000 {
-		compatible = "bcm,kona-sdhci";
+		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <0x0 73 0x4>;
 		status = "disabled";
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 56d9d19..bcc1c59 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -36,7 +36,8 @@ struct bcm_kona_smc_data {
 };
 
 static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
-	{.compatible = "bcm,kona-smc"},
+	{.compatible = "brcm,kona-smc"},
+	{.compatible = "bcm,kona-smc"}, /* deprecated name */
 	{},
 };
 
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 2859932..6296fdf 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -50,7 +50,7 @@ static void __init board_init(void)
 	kona_l2_cache_init();
 }
 
-static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
+static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
 
 DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
 	.init_time = clocksource_of_init,
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d70e0ab..0c19af6 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -929,7 +929,9 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 	  .data = (void *)&aurora_no_outer_data},
 	{ .compatible = "marvell,aurora-outer-cache",
 	  .data = (void *)&aurora_with_outer_data},
-	{ .compatible = "bcm,bcm11351-a2-pl310-cache",
+	{ .compatible = "brcm,bcm11351-a2-pl310-cache",
+	  .data = (void *)&bcm_l2x0_data},
+	{ .compatible = "bcm,bcm11351-a2-pl310-cache", /* deprecated name */
 	  .data = (void *)&bcm_l2x0_data},
 	{}
 };
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index ba3d859..0d7d8c3 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -99,7 +99,8 @@ kona_timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)
 }
 
 static const struct of_device_id bcm_timer_ids[] __initconst = {
-	{.compatible = "bcm,kona-timer"},
+	{.compatible = "brcm,kona-timer"},
+	{.compatible = "bcm,kona-timer"}, /* deprecated name */
 	{},
 };
 
@@ -201,4 +202,9 @@ static void __init kona_timer_init(struct device_node *node)
 	kona_timer_set_next_event((arch_timer_rate / HZ), NULL);
 }
 
+CLOCKSOURCE_OF_DECLARE(brcm_kona, "brcm,kona-timer", kona_timer_init);
+/*
+ * bcm,kona-timer is deprecated by brcm,kona-timer
+ * being kept here for driver compatibility
+ */
 CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer", kona_timer_init);
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 87175f9..887482a 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -222,7 +222,8 @@ static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
 };
 
 static const struct of_device_id sdhci_bcm_kona_of_match[] __initdata = {
-	{ .compatible = "bcm,kona-sdhci"},
+	{ .compatible = "brcm,kona-sdhci"},
+	{ .compatible = "bcm,kona-sdhci"}, /* deprecated name */
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_bcm_kona_of_match);
-- 
1.7.10.4
