From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Jul 2014 22:54:27 +0800
Subject: [PATCH] ARM: dt: sun6i: Add #address-cells and #size-cells to i2c
 controller nodes
Message-ID: <1405954467-29331-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc was giving warnings for missing #address-cells and #size-cells for
the new sun6i-a31-hummingbird.dts, which has a i2c-based rtc device.

This patch adds the properties for all i2c controller nodes for sun6i.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

This is a fix to get rid of warnings from dtc when building sun6i dts.
Sorry for now catching it earlier.


Cheers
ChenYu

---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 44b07e5..e06fbfc 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -660,6 +660,8 @@
 			clock-frequency = <100000>;
 			resets = <&apb2_rst 0>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -670,6 +672,8 @@
 			clock-frequency = <100000>;
 			resets = <&apb2_rst 1>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c2: i2c at 01c2b400 {
@@ -680,6 +684,8 @@
 			clock-frequency = <100000>;
 			resets = <&apb2_rst 2>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c3: i2c at 01c2b800 {
@@ -690,6 +696,8 @@
 			clock-frequency = <100000>;
 			resets = <&apb2_rst 3>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		gmac: ethernet at 01c30000 {
-- 
2.0.1
