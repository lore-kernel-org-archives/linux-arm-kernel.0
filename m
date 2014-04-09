From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  9 Apr 2014 19:08:16 +0400
Subject: [PATCH v3] ARM: dts: i.MX: Use single naming style for i.MX WEIM
 device
Message-ID: <1397056096-29233-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts all i.MX WEIM users to use single naming style
for devices.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 9117a3c..8b4181b 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -280,7 +280,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_weim>;
 
-	can at d4000000 {
+	can at 4,0 {
 		compatible = "nxp,sja1000";
 		reg = <4 0x00000000 0x00000100>;
 		interrupt-parent = <&gpio5>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 8e10aef..d7ed63c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -311,7 +311,7 @@
 &weim {
 	status = "okay";
 
-	nor: nor at c0000000 {
+	nor: nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
@@ -321,7 +321,7 @@
 		#size-cells = <1>;
 	};
 
-	sram: sram at c8000000 {
+	sram: sram at 1,0 {
 		compatible = "mtd-ram";
 		reg = <1 0x00000000 0x00800000>;
 		bank-width = <2>;
-- 
1.8.3.2
