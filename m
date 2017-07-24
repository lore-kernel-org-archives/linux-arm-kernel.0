From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 24 Jul 2017 15:48:46 +0200
Subject: [PATCH net-next 16/18] arm64: dts: marvell: mcbin: enable more
 networking ports
In-Reply-To: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
Message-ID: <20170724134848.19330-17-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the two GE/SFP ports. They are configured in 10GKR
mode by default. To do this the cpm_xdmio is enabled as well, and two
phy descriptions are added.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

@Dave: Hi! This patch should go through the mvebu tree. Thanks!

 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index abd39d1c1739..6cb4b000e1ac 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -127,6 +127,30 @@
 	};
 };
 
+&cpm_xmdio {
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+	};
+};
+
+&cpm_ethernet {
+	status = "okay";
+};
+
+&cpm_eth0 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "10gbase-kr";
+};
+
 &cpm_sata0 {
 	/* CPM Lane 0 - U29 */
 	status = "okay";
@@ -154,6 +178,12 @@
 	status = "okay";
 };
 
+&cps_eth0 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "10gbase-kr";
+};
+
 &cps_eth1 {
 	/* CPS Lane 0 - J5 (Gigabit RJ45) */
 	status = "okay";
-- 
2.13.3
