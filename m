From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 24 Jul 2017 15:48:48 +0200
Subject: [PATCH net-next 18/18] arm64: dts: marvell: 8040-db: enable the SFP
 ports
In-Reply-To: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
Message-ID: <20170724134848.19330-19-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the SFP ports on the Armada 8040 DB as these ports
are now supported by the PPv2 driver (since the PHY is now optional).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

@Dave: Hi! This patch should go through the mvebu tree. Thanks!

 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 1e8f7242ed6f..83c7d8f2f710 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -136,6 +136,11 @@
 	status = "okay";
 };
 
+&cpm_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+};
+
 &cpm_eth2 {
 	status = "okay";
 	phy = <&phy1>;
@@ -179,6 +184,11 @@
 	status = "okay";
 };
 
+&cps_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+};
+
 &cps_eth1 {
 	status = "okay";
 	phy = <&phy0>;
-- 
2.13.3
