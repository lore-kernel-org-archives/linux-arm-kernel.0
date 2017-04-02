From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun,  2 Apr 2017 23:08:40 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify MDIO bus in the DT
Message-ID: <20170402210840.11429-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Northstar devices have MDIO bus that may contain various PHYs attached.
A common example is USB 3.0 PHY (that doesn't have an MDIO driver yet).

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index acee36a61004..6a2afe7880ae 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -320,6 +320,13 @@
 		};
 	};
 
+	mdio at 18003000 {
+		compatible = "brcm,iproc-mdio";
+		reg = <0x18003000 0x8>;
+		#size-cells = <1>;
+		#address-cells = <0>;
+	};
+
 	i2c0: i2c at 18009000 {
 		compatible = "brcm,iproc-i2c";
 		reg = <0x18009000 0x50>;
-- 
2.11.0
