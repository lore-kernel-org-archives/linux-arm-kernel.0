From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:51 +0100
Subject: [PATCH net-next 10/10] arm64: dts: marvell: mcbin: enable the fourth
 network interface
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-11-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the fourth network interface on the Marvell
Macchiatobin. It is configured in the 2500Base-X PHY mode.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 626e9d0462c3..1ce31bfe6197 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -66,6 +66,7 @@
 		ethernet0 = &cp0_eth0;
 		ethernet1 = &cp1_eth0;
 		ethernet2 = &cp1_eth1;
+		ethernet3 = &cp1_eth2;
 	};
 
 	/* Regulator labels correspond with schematics */
@@ -285,6 +286,16 @@
 	phys = <&cp1_comphy0 1>;
 };
 
+&cp1_eth2 {
+	/* CPS Lane 5 */
+	status = "okay";
+	/* Network PHY */
+	phy-mode = "2500base-x";
+	managed = "in-band-status";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy5 2>;
+};
+
 &cp1_pinctrl {
 	cp1_spi1_pins: spi1-pins {
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
-- 
2.14.3
