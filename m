From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  5 Jun 2017 21:01:07 +0100
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
Message-ID: <20170605200107.7692-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the 1GB Ethernet interface that lives on the slave CP110,
with its corresponding phy (that oddly lives on the master CP110).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index f7bb0cc03147..1eb3cd5332c1 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -100,6 +100,12 @@
 	status = "okay";
 };
 
+&cpm_mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &cpm_sata0 {
 	/* CPM Lane 0 - U29 */
 	status = "okay";
@@ -115,6 +121,16 @@
 	status = "okay";
 };
 
+&cps_ethernet {
+	status = "okay";
+};
+
+&cps_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "sgmii";
+};
+
 &cps_sata0 {
 	/* CPS Lane 1 - U32 */
 	/* CPS Lane 3 - U31 */
-- 
2.11.0
