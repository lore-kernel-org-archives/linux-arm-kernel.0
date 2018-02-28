From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Wed, 28 Feb 2018 14:11:21 +0100
Subject: [PATCH 2/3] ARM: dts: sun8i: a711: set regulator for each cluster of
 CPUs
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
Message-ID: <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A83T is a SoC with two clusters of 4 A7 which have a
different clock and regulator.

Set the CPU regulator.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1de362f..d65162c 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -128,6 +128,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu100 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &de {
 	status = "okay";
 };
@@ -136,6 +144,7 @@
  * An USB-2 hub is connected here, which also means we don't need to
  * enable the OHCI controller.
  */
+
 &ehci0 {
 	status = "okay";
 };
-- 
git-series 0.9.1
