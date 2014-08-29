From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 29 Aug 2014 15:51:03 +0200
Subject: [PATCH 5/5] ARM: dts: berlin: enable the Ethernet port on the BG2Q DMP
In-Reply-To: <1409320263-10295-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1409320263-10295-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1409320263-10295-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the Ethernet port on the Marvell Berlin2Q DMP board.
The Ethernet PHY node is also added.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index a357ce02a64e..1826534ffce3 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -45,3 +45,16 @@
 &uart0 {
 	status = "okay";
 };
+
+&eth0 {
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
-- 
1.9.1
