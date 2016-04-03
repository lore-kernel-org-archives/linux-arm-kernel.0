From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:46 +0200
Subject: [PATCH 4/8] ARM: kirkwood: DT: Add address to ethernet-phy unit name
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHYs have an address on the mdio bus. So the unit name should contain
an address. This is complicated in that some .dtsi files contain the
node, but the reg is set in the .dts file. In this case, use the
abstract address X.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi | 2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts       | 2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index b4d59261eddc..282605f4c92c 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -83,7 +83,7 @@
 &mdio {
 	status = "okay";
 
-	ethphy0: ethernet-phy {
+	ethphy0: ethernet-phy at X {
                 /* overwrite reg property in board file */
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index af5ce85b2c38..860c6d778d47 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -217,7 +217,7 @@
 &mdio {
 	status = "okay";
 
-	ethphy0: ethernet-phy {
+	ethphy0: ethernet-phy at 8 {
 		device_type = "ethernet-phy";
 		reg = <8>;
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 0e46560551f4..b3f75382cb06 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -94,7 +94,7 @@
 &mdio {
 	status = "okay";
 
-	ethphy0: ethernet-phy {
+	ethphy0: ethernet-phy at X {
                 /* overwrite reg property in board file */
 	};
 };
-- 
2.7.0
