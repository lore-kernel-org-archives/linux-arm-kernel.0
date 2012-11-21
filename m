From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:30 +0100
Subject: [PATCH 1/5] ARM: mvebu: Add support for I2C controllers in Armada
 370/XP
In-Reply-To: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353536675-15010-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

The Armada 370 and Armada XP have the same I2C controllers as previous
Marvell SoCs, so the existing mv64xxx-i2c driver works fine.

[Thomas Petazzoni: updated on top of other Armada 370/XP changes,
rephrased the commit log].
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 4ff1081..70c35f8 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -101,6 +101,28 @@
 				clocks = <&gateclk 3>;
 				status = "disabled";
 		};
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
1.7.9.5
