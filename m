From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:42 +0200
Subject: [PATCH net-next v2 12/13] arm64: dts: marvell: 7040-db: describe the
 10G SFP cage
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-13-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SFP cage description for the 10G interface in the
Marvell Armada 7040 DB board.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index d6bec058a30a..10a429dcaab7 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -55,6 +55,10 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp0_reg_usb3_1_vbus>;
 	};
+
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+	};
 };
 
 &i2c0 {
@@ -240,8 +244,10 @@
 	status = "okay";
 	/* Network PHY */
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp_eth0>;
 };
 
 &cp0_eth1 {
-- 
2.17.0
