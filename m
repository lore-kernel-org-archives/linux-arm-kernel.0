From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:35 +0200
Subject: [PATCH v3 07/11] arm64: dts: marvell: use the proper I2C controller
 compatible string for 7K/8K
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C controller found in the Marvell Armada 7K/8K provides the
bridge/offloading features, so the Device Tree should use the
marvell,mv78230-i2c compatible string instead of marvell,mv64xxx-i2c.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 38be192..20d256b 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -184,7 +184,7 @@
 			};
 
 			i2c0: i2c at 511000 {
-				compatible = "marvell,mv64xxx-i2c";
+				compatible = "marvell,mv78230-i2c";
 				reg = <0x511000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.6.4
