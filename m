From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Thu, 17 May 2018 10:29:38 +0200
Subject: [PATCH net-next v3 09/10] arm64: dts: marvell: 8040-db: describe the
 10G interfaces as fixed-link
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
Message-ID: <20180517082939.14598-10-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a fixed-link node to both 10G interfaces of the 8040-db
board. This is required as the mvpp2 driver now uses phylink. The best
solution would have been to describe the SFP cages but they are not
wired correctly, and thus unusable, so we chose to use fixed-link
instead.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 5689fb23bbab..1bac437369a1 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -177,6 +177,11 @@
 &cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+
+	fixed-link {
+		speed = <10000>;
+		full-duplex;
+	};
 };
 
 &cp0_eth2 {
@@ -303,6 +308,11 @@
 &cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+
+	fixed-link {
+		speed = <10000>;
+		full-duplex;
+	};
 };
 
 &cp1_eth1 {
-- 
2.17.0
