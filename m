From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:14:03 -0700
Subject: [PATCH RFC 4/5] ARM: dts: imx: change compatiblity for SPI
 controllers on imx53 later soc
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1492085644-4195-5-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

for SPI controllers on imx53 and later SoCs, there is HW issue when
work in slave mode, as new device type 'IMX53_ECSPI' has been added
for these SPI controllers which is compatible with 'fsl,imx53-ecspi'.

This patch updates DTS to make imx53 later SPI controller only be
compatibile with 'fsl,imx53-ecspi'.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm/boot/dts/imx53.dtsi   | 4 ++--
 arch/arm/boot/dts/imx6q.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 arch/arm/boot/dts/imx6sl.dtsi  | 8 ++++----
 arch/arm/boot/dts/imx6sx.dtsi  | 8 ++++----
 arch/arm/boot/dts/imx6ul.dtsi  | 8 ++++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 2e516f4..9eeafb9 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -243,7 +243,7 @@
 				ecspi1: ecspi at 50010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx53-ecspi";
 					reg = <0x50010000 0x4000>;
 					interrupts = <36>;
 					clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
@@ -662,7 +662,7 @@
 			ecspi2: ecspi at 63fac000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+				compatible = "fsl,imx53-ecspi";
 				reg = <0x63fac000 0x4000>;
 				interrupts = <37>;
 				clocks = <&clks IMX5_CLK_ECSPI2_IPG_GATE>,
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9a5d0b..7373671 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -90,7 +90,7 @@
 				ecspi5: ecspi at 02018000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6q-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6d7bf64..4a4b509 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -265,7 +265,7 @@
 				ecspi1: ecspi at 02008000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6q-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
@@ -279,7 +279,7 @@
 				ecspi2: ecspi at 0200c000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6q-ecspi", "fsl,imx53-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
@@ -293,7 +293,7 @@
 				ecspi3: ecspi at 02010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6q-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
@@ -307,7 +307,7 @@
 				ecspi4: ecspi at 02014000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6q-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index cc9572e..1d1200c 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -168,7 +168,7 @@
 				ecspi1: ecspi at 02008000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sl-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_ECSPI1>,
@@ -180,7 +180,7 @@
 				ecspi2: ecspi at 0200c000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sl-ecspi", "fsl,imx53-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_ECSPI2>,
@@ -192,7 +192,7 @@
 				ecspi3: ecspi at 02010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sl-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_ECSPI3>,
@@ -204,7 +204,7 @@
 				ecspi4: ecspi at 02014000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sl-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_ECSPI4>,
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index dd4ec85..c115ed3 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -251,7 +251,7 @@
 				ecspi1: ecspi at 02008000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sx-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ECSPI1>,
@@ -263,7 +263,7 @@
 				ecspi2: ecspi at 0200c000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sx-ecspi", "fsl,imx53-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ECSPI2>,
@@ -275,7 +275,7 @@
 				ecspi3: ecspi at 02010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sx-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ECSPI3>,
@@ -287,7 +287,7 @@
 				ecspi4: ecspi at 02014000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6sx-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ECSPI4>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d..d35ad5b 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -204,7 +204,7 @@
 				ecspi1: ecspi at 02008000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_ECSPI1>,
@@ -216,7 +216,7 @@
 				ecspi2: ecspi at 0200c000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx53-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_ECSPI2>,
@@ -228,7 +228,7 @@
 				ecspi3: ecspi at 02010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_ECSPI3>,
@@ -240,7 +240,7 @@
 				ecspi4: ecspi at 02014000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx53-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6UL_CLK_ECSPI4>,
-- 
2.7.4
