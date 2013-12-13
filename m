From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:57 +0900
Subject: [PATCH 23/69] ARM: shmobile: sh73a0: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <33f6be3bf6b79c2b9b7c8cd1387e8e7d4b839d9e.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi         | 8 ++++----
 arch/arm/mach-shmobile/clock-sh73a0.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index fcf2688..78f7201a 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -190,7 +190,7 @@
 		status = "disabled";
 	};
 
-	mmcif: mmcif at e6bd0000 {
+	mmcif: mmc at e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
@@ -200,7 +200,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi at ee100000 {
+	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
@@ -212,7 +212,7 @@
 	};
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
-	sdhi1: sdhi at ee120000 {
+	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
@@ -223,7 +223,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi at ee140000 {
+	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index c92c023..96cc7da 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -663,13 +663,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6822000.i2c", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP322]), /* USB */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
-	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]), /* SDHI0 */
+	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
-	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]), /* SDHI1 */
+	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
-	CLKDEV_DEV_ID("e6bd0000.mmcif", &mstp_clks[MSTP312]), /* MMCIF0 */
+	CLKDEV_DEV_ID("e6bd0000.mmc", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
-	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP311]), /* SDHI2 */
+	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP311]), /* SDHI2 */
 	CLKDEV_DEV_ID("renesas-tpu-pwm.0", &mstp_clks[MSTP304]), /* TPU0 */
 	CLKDEV_DEV_ID("renesas-tpu-pwm.1", &mstp_clks[MSTP303]), /* TPU1 */
 	CLKDEV_DEV_ID("renesas-tpu-pwm.2", &mstp_clks[MSTP302]), /* TPU2 */
-- 
1.8.4
