From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 16:25:54 +0100
Subject: [PATCH v7 04/13] ARM: dts: berlin: add a required reset property in
 the chip controller node
In-Reply-To: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1415978763-27345-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip controller node now also describes the Marvell Berlin reset
controller. Add the required 'reset-cells' property.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/berlin2.dtsi   | 1 +
 arch/arm/boot/dts/berlin2cd.dtsi | 1 +
 arch/arm/boot/dts/berlin2q.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 9d7c810ebd0b..d7e81e124de0 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -249,6 +249,7 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2-chip-ctrl";
 			#clock-cells = <1>;
+			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index cc1df65da504..68f7032b4686 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -231,6 +231,7 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2cd-chip-ctrl";
 			#clock-cells = <1>;
+			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 891d56b03922..2de8d6f8973c 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -349,6 +349,7 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2q-chip-ctrl";
 			#clock-cells = <1>;
+			#reset-cells = <2>;
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
-- 
2.1.0
