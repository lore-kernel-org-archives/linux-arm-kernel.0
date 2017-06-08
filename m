From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Jun 2017 11:42:43 +0100
Subject: [PATCH v2] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
Message-ID: <20170608104243.12476-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the 1GB Ethernet interface that lives on the slave CP110,
with its corresponding phy (that oddly lives on the master CP110).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1: 
  - renamed phy0 -> ge_phy (rmk)
  - Added lane number and connector location (rmk)

 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index f7bb0cc03147..e7296b2d0f0f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -100,6 +100,12 @@
 	status = "okay";
 };
 
+&cpm_mdio {
+	ge_phy: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &cpm_sata0 {
 	/* CPM Lane 0 - U29 */
 	status = "okay";
@@ -115,6 +121,17 @@
 	status = "okay";
 };
 
+&cps_ethernet {
+	status = "okay";
+};
+
+&cps_eth1 {
+	/* CPS Lane 0 - J5 (Gigabit RJ45) */
+	status = "okay";
+	phy = <&ge_phy>;
+	phy-mode = "sgmii";
+};
+
 &cps_sata0 {
 	/* CPS Lane 1 - U32 */
 	/* CPS Lane 3 - U31 */
-- 
2.11.0
