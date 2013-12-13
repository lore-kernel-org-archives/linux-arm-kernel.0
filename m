From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:52 +0900
Subject: [PATCH 18/69] ARM: shmobile: r8a7740: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <7d907894bfe3848a033aa19a2dbb12105300b8e5.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name and related clock.

This patch also adds missing SDHI2 entry

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi         | 18 +++++++++++++++---
 arch/arm/mach-shmobile/clock-r8a7740.c |  8 ++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index ae1e230..4cc945a 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -162,7 +162,7 @@
 		#pwm-cells = <3>;
 	};
 
-	mmcif0: mmcif at e6bd0000 {
+	mmcif0: mmc at e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
@@ -171,7 +171,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi at e6850000 {
+	sdhi0: sd at e6850000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6850000 0x100>;
 		interrupt-parent = <&gic>;
@@ -183,7 +183,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi at e6860000 {
+	sdhi1: sd at e6860000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6860000 0x100>;
 		interrupt-parent = <&gic>;
@@ -194,4 +194,16 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	sdhi2: sd at e6870000 {
+		compatible = "renesas,sdhi-r8a7740";
+		reg = <0xe6870000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 125 4
+				0 126 4
+				0 127 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index e9a3c64..dd989f9 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -590,18 +590,18 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6c20000.i2c",		&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("e6850000.sdhi",          &mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("e6850000.sd",		&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("e6860000.sdhi",          &mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("e6860000.sd",		&mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("e6bd0000.mmc",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
 	CLKDEV_DEV_ID("e6600000.pwm",		&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
-	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
+	CLKDEV_DEV_ID("e6870000.sd",		&mstp_clks[MSTP415]),
 
 	/* ICK */
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
-- 
1.8.4
