From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 26 Sep 2013 08:11:19 +0900
Subject: [PATCH] ARM: shmobile: Add r8a7790 thermal sensor DT device
Message-ID: <20130925231119.16473.31647.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up the single channel thermal sensor via DT
on r8a7790. The information used by the platform
device has been verified against the data sheet.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20130925

 arch/arm/boot/dts/r8a7790.dtsi         |    7 +++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |    1 +
 2 files changed, 8 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-09-26 07:23:04.000000000 +0900
@@ -87,6 +87,13 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	thermal at e61f0000 {
+		compatible = "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 69 4>;
+	};
+
 	gpio0: gpio at ffc40000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xffc40000 0 0x2c>;
--- 0001/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2013-09-26 07:24:37.000000000 +0900
@@ -272,6 +272,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
+	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
