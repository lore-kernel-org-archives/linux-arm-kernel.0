From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 21 Sep 2017 09:54:07 +0200
Subject: [PATCH v2 1/4] arm64: dts: marvell: mcbin: add comphy references to
 Ethernet ports
In-Reply-To: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
References: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
Message-ID: <20170921075410.19072-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds comphy phandles to the Ethernet ports in the mcbin
device tree. The comphy is used to configure the serdes PHYs used by
these ports.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index acf5c7d16d79..49d6590507b5 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -222,8 +222,11 @@
 
 &cpm_eth0 {
 	status = "okay";
+	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cpm_comphy4 0>;
 };
 
 &cpm_sata0 {
@@ -257,15 +260,21 @@
 
 &cps_eth0 {
 	status = "okay";
+	/* Network PHY */
 	phy = <&phy8>;
 	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cps_comphy4 0>;
 };
 
 &cps_eth1 {
 	/* CPS Lane 0 - J5 (Gigabit RJ45) */
 	status = "okay";
+	/* Network PHY */
 	phy = <&ge_phy>;
 	phy-mode = "sgmii";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cps_comphy0 1>;
 };
 
 &cps_pinctrl {
-- 
2.13.5
