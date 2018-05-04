From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:43 +0200
Subject: [PATCH net-next v2 13/13] arm64: dts: marvell: 8040-db: describe the
 10G SFP cages
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-14-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SFP cages description for the 10G interfaces in the
Marvell Armada 8080 DB board.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 5689fb23bbab..0a9aeac71614 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -70,6 +70,14 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp1_reg_usb3_0_vbus>;
 	};
+
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+	};
+
+	sfp_eth1: sfp-eth1 {
+		compatible = "sff,sfp";
+	};
 };
 
 &i2c0 {
@@ -177,6 +185,8 @@
 &cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth0>;
 };
 
 &cp0_eth2 {
@@ -303,6 +313,8 @@
 &cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth1>;
 };
 
 &cp1_eth1 {
-- 
2.17.0
