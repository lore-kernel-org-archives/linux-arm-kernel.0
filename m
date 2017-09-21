From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 21 Sep 2017 09:54:08 +0200
Subject: [PATCH v2 2/4] arm64: dts: marvell: 7040-db: add comphy reference to
 Ethernet port
In-Reply-To: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
References: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
Message-ID: <20170921075410.19072-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a comphy phandle to the Ethernet port in the 7040-db
device tree. The comphy is used to configure the serdes PHYs used by
these ports.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 9c3bdf87e543..06a7ea549a8f 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -217,8 +217,11 @@
 
 &cpm_eth1 {
 	status = "okay";
+	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "sgmii";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cpm_comphy0 1>;
 };
 
 &cpm_eth2 {
-- 
2.13.5
