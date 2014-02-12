From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:20:59 +0100
Subject: [PATCH v2 4/7] ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392225662-20431-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a pin-muxing configuration for the I2C0 bus of the
Armada 370, which is used on the Armada 370 DB platform to interface
with the CS42L51 audio codec.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index e3f4c18..6f216f0 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -133,6 +133,11 @@
 					marvell,function = "sd0";
 				};
 
+				i2c0_pins: i2c0-pins {
+					marvell,pins = "mpp2", "mpp3";
+					marvell,function = "i2c0";
+				};
+
 				i2s_pins1: i2s-pins1 {
 					marvell,pins = "mpp5", "mpp6", "mpp7",
 						       "mpp8", "mpp9", "mpp10",
-- 
1.8.3.2
