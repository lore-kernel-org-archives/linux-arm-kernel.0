From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 30 Oct 2012 19:41:23 +0900
Subject: [PATCH 1/3] ARM: mvebu: Add support I2C controller
Message-ID: <1351593685-19663-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu arch has the same I2C controller as mv64xxx-i2c.
This support mv64xxx-i2c on mvebu.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index d0ea4a6..5da85c2 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -83,6 +83,29 @@
                                interrupts = <10>;
                                status = "disabled";
                 };
+
+
+		i2c0: i2c at d0011000 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0xd0011000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <31>;
+			timeout-ms = <1000>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at d0011100 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0xd0011100 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <32>;
+			timeout-ms = <1000>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.10.4
