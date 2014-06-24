From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 24 Jun 2014 12:35:13 +0200
Subject: [PATCH v2 04/12] ARM: dts: berlin: add a required reset property in
 the chip controller node
In-Reply-To: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403606121-6368-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip controller node now also describes the Marvell Berlin reset
controller. Add the required 'reset-cells' property.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 1 +
 arch/arm/boot/dts/berlin2cd.dtsi | 1 +
 arch/arm/boot/dts/berlin2q.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 2477dac4d643..97b12492675e 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -243,6 +243,7 @@
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
index 635a16a64cb4..a6f7ec325200 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -298,6 +298,7 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2q-chip-ctrl";
 			#clock-cells = <1>;
+			#reset-cells = <2>;
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
-- 
1.9.1
