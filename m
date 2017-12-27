From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 Dec 2017 23:14:45 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the fourth
 network interface
In-Reply-To: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
Message-ID: <20171227221446.18459-6-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the fourth network interface on the Marvell
Macchiatobin. It is configured in the 2500Base-X PHY mode.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index b3350827ee55..c51efd511324 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -279,6 +279,14 @@
 	phys = <&cps_comphy0 1>;
 };
 
+&cps_eth2 {
+	/* CPS Lane 5 */
+	status = "okay";
+	phy-mode = "2500base-x";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cps_comphy5 2>;
+};
+
 &cps_pinctrl {
 	cps_spi1_pins: spi1-pins {
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
-- 
2.14.3
