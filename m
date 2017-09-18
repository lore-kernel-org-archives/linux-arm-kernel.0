From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:13 +0200
Subject: [PATCH 8/9] arm64: dts: marvell: 7040-db: enable the SFP port
In-Reply-To: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918075814.27405-9-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the SFP port on the Armada 7040 DB as this port
is now supported by the PPv2 driver (since the PHY is now optional).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 274d203dac13..9ca9aa8ec46e 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -215,6 +215,12 @@
 	status = "okay";
 };
 
+&cpm_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+	phys = <&cpm_comphy2 0>;
+};
+
 &cpm_eth1 {
 	status = "okay";
 	phy = <&phy0>;
-- 
2.13.5
