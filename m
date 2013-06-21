From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 21 Jun 2013 09:10:36 +0200
Subject: [PATCH 2/4] ARM: shmobile: r8a73a4: add I2C DT nodes and required
 clocks
In-Reply-To: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1371798638-10530-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a73a4 SoCs have numerous I2C controllers, of which 9 are compatible
with the i2c-sh_mobile.c driver. This patch adds Device Tree nodes and
clock definitions for them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi         |   81 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c |   25 +++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4ff2019..4e1ddf0 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -85,4 +85,85 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	i2c0: i2c at e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 174 0x4>;
+	};
+
+	i2c1: i2c at e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 175 0x4>;
+	};
+
+	i2c2: i2c at e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6520000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 176 0x4>;
+	};
+
+	i2c3: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6530000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 177 0x4>;
+	};
+
+	i2c4: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6540000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 178 0x4>;
+	};
+
+	i2c5: i2c at e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 179 0x4>;
+	};
+
+	i2c6: i2c at e6550000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6550000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 184 0x4>;
+	};
+
+	i2c7: i2c at e6560000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6560000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 185 0x4>;
+	};
+
+	i2c8: i2c at e6570000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6570000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 173 0x4>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index cbf9852..508cb1e 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -30,6 +30,7 @@
 
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
+#define SMSTPCR4 0xe6150140
 #define SMSTPCR5 0xe6150144
 
 #define FRQCRA		0xE6150000
@@ -487,8 +488,10 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
-	MSTP315, MSTP314, MSTP313, MSTP312, MSTP305,
-	MSTP522,
+	MSTP323, MSTP318, MSTP317, MSTP316,
+	MSTP315, MSTP314, MSTP313, MSTP312, MSTP305, MSTP300,
+	MSTP411, MSTP410, MSTP409,
+	MSTP522, MSTP515,
 	MSTP_NR
 };
 
@@ -499,12 +502,21 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP207] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP216] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 16, 0), /* SCIFB2 */
 	[MSTP217] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 17, 0), /* SCIFB3 */
+	[MSTP300] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 0, 0), /* IIC2 */
 	[MSTP305] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC1],SMSTPCR3, 5, 0), /* MMCIF1 */
 	[MSTP312] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI2],SMSTPCR3, 12, 0), /* SDHI2 */
 	[MSTP313] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI1],SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP314] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI0],SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0],SMSTPCR3, 15, 0), /* MMCIF0 */
+	[MSTP316] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 16, 0), /* IIC6 */
+	[MSTP317] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 17, 0), /* IIC7 */
+	[MSTP318] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 18, 0), /* IIC0 */
+	[MSTP323] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP409] = SH_CLK_MSTP32(&main_div2_clk,	SMSTPCR4, 9, 0), /* IIC5 */
+	[MSTP410] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 10, 0), /* IIC4 */
+	[MSTP411] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP522] = SH_CLK_MSTP32(&extal2_clk, SMSTPCR5, 22, 0), /* Thermal */
+	[MSTP515] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR5, 15, 0), /* IIC8 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -549,6 +561,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("e6520000.i2c", &mstp_clks[MSTP300]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
@@ -559,6 +572,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
+	CLKDEV_DEV_ID("e6550000.i2c", &mstp_clks[MSTP316]),
+	CLKDEV_DEV_ID("e6560000.i2c", &mstp_clks[MSTP317]),
+	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
+	CLKDEV_DEV_ID("e6510000.i2c", &mstp_clks[MSTP323]),
+	CLKDEV_DEV_ID("e60b0000.i2c", &mstp_clks[MSTP409]),
+	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP410]),
+	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP411]),
+	CLKDEV_DEV_ID("e6570000.i2c", &mstp_clks[MSTP515]),
 
 	/* for DT */
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
-- 
1.7.2.5
