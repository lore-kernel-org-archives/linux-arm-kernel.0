From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 24 Nov 2016 10:31:24 +0100
Subject: [PATCH] ARM: dts: da850: enable the memctrl and mstpri nodes per board
Message-ID: <1479979884-9624-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the memory controller and master priorities drivers are
enabled in da850.dtsi. For boards for which there are no settings
defined, this makes these drivers emit error messages.

Disable the nodes in da850.dtsi and only enable them for da850-lcdk -
the only board that currently needs them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 3b99a88..94504c8 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -283,3 +283,11 @@
 &display {
 	status = "okay";
 };
+
+&prictrl {
+	status = "okay";
+};
+
+&memctrl {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 36066fa..4e40187 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -212,6 +212,7 @@
 		prictrl: priority-controller at 14110 {
 			compatible = "ti,da850-mstpri";
 			reg = <0x14110 0x0c>;
+			status = "disabled";
 		};
 		cfgchip: chip-controller at 1417c {
 			compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
@@ -457,5 +458,6 @@
 	memctrl: memory-controller at b0000000 {
 		compatible = "ti,da850-ddr-controller";
 		reg = <0xb0000000 0xe8>;
+		status = "disabled";
 	};
 };
-- 
2.9.3
