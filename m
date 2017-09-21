From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 21 Sep 2017 09:54:09 +0200
Subject: [PATCH v2 3/4] arm64: dts: marvell: 7040-db: enable the SFP port
In-Reply-To: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
References: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
Message-ID: <20170921075410.19072-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the SFP port on the Armada 7040 DB as this port
is now supported by the PPv2 driver (since the PHY is now optional).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 06a7ea549a8f..7457b2ea9c4e 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -215,6 +215,14 @@
 	status = "okay";
 };
 
+&cpm_eth0 {
+	status = "okay";
+	/* Network PHY */
+	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cpm_comphy2 0>;
+};
+
 &cpm_eth1 {
 	status = "okay";
 	/* Network PHY */
-- 
2.13.5
