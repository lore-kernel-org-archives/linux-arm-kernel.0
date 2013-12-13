From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:53 +0900
Subject: [PATCH 19/69] ARM: shmobile: r8a73a4: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <43304a5f51066a7ef851732c35b4582a8d6a5bc0.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi         | 10 +++++-----
 arch/arm/mach-shmobile/clock-r8a73a4.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 287e047..e079c99 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -219,7 +219,7 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmcif at ee200000 {
+	mmcif0: mmc at ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -228,7 +228,7 @@
 		status = "disabled";
 	};
 
-	mmcif1: mmcif at ee220000 {
+	mmcif1: mmc at ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -244,7 +244,7 @@
 		#gpio-cells = <2>;
 	};
 
-	sdhi0: sdhi at ee100000 {
+	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -253,7 +253,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi at ee120000 {
+	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -262,7 +262,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi at ee140000 {
+	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 571409b..7348d58 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -584,15 +584,15 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("e6520000.i2c", &mstp_clks[MSTP300]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
-	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("ee220000.mmc", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
+	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("e6550000.i2c", &mstp_clks[MSTP316]),
 	CLKDEV_DEV_ID("e6560000.i2c", &mstp_clks[MSTP317]),
 	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
-- 
1.8.4
