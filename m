From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 25 Nov 2016 17:03:15 +0100
Subject: [PATCH 3/3] ARM: dts: da850: enable the memctrl and mstpri nodes per
 board
In-Reply-To: <1480089795-29811-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480089795-29811-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480089795-29811-4-git-send-email-bgolaszewski@baylibre.com>
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
index 6952c68..d0f7680 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -285,3 +285,11 @@
 		remote-endpoint = <&vga_bridge_in>;
 	};
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
index 9b7c444..2ea0e06 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -213,6 +213,7 @@
 		prictrl: priority-controller at 14110 {
 			compatible = "ti,da850-mstpri";
 			reg = <0x14110 0x0c>;
+			status = "disabled";
 		};
 		cfgchip: chip-controller at 1417c {
 			compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
@@ -486,5 +487,6 @@
 	memctrl: memory-controller at b0000000 {
 		compatible = "ti,da850-ddr-controller";
 		reg = <0xb0000000 0xe8>;
+		status = "disabled";
 	};
 };
-- 
2.9.3
