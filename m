From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:56 +0900
Subject: [PATCH 22/69] ARM: shmobile: r8a7790: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <b718aa448378a83c698f92073a4aa24df0d9444b.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi         | 10 +++++-----
 arch/arm/mach-shmobile/clock-r8a7790.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee845fa..5ae7db6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -225,7 +225,7 @@
 		status = "disabled";
 	};
 
-	mmcif1: mmcif at ee220000 {
+	mmcif1: mmc at ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -239,7 +239,7 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
-	sdhi0: sdhi at ee100000 {
+	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -248,7 +248,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi at ee120000 {
+	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -257,7 +257,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi at ee140000 {
+	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -266,7 +266,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi at ee160000 {
+	sdhi3: sd at ee160000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 36c8917..092975a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -298,17 +298,17 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
-	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
+	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("ee160000.sdhi", &mstp_clks[MSTP311]),
+	CLKDEV_DEV_ID("ee160000.sd", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
-	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
+	CLKDEV_DEV_ID("ee220000.mmc", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
-- 
1.8.4
