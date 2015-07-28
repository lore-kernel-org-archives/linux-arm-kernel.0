From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 28 Jul 2015 19:09:10 +0530
Subject: [PATCH 2/2] ARM: dts: am57xx-evm: Add 'gpios' property with gpio2_8
In-Reply-To: <1438090750-11604-1-git-send-email-kishon@ti.com>
References: <1438090750-11604-1-git-send-email-kishon@ti.com>
Message-ID: <1438090750-11604-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio2_8 is connected to the PCIe_RESETn line and it has to be driven low
in order to reset the PCIe cards. So added gpios property to pcie
dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    5 +++++
 arch/arm/boot/dts/dra7.dtsi             |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a63bf78..a862a6e 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -693,3 +693,8 @@
 		};
 	};
 };
+
+&pcie1 {
+	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+};
+
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25b..37202b4 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -211,7 +211,7 @@
 			#address-cells = <1>;
 			ranges = <0x51000000 0x51000000 0x3000
 				  0x0	     0x20000000 0x10000000>;
-			pcie at 51000000 {
+			pcie1: pcie at 51000000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
-- 
1.7.9.5
