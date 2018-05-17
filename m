From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Thu, 17 May 2018 10:29:39 +0200
Subject: [PATCH net-next v3 10/10] arm64: dts: marvell: 7040-db: describe the
 10G interface as fixed-link
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
Message-ID: <20180517082939.14598-11-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a fixed-link node to the 10G interface of the 7040-db
board. This is required as the mvpp2 driver now uses phylink. The best
solution would have been to describe the SFP cage but they are not
wired correctly, and thus unusable, so we chose to use fixed-link
instead.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index d6bec058a30a..412efdb46e7c 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -242,6 +242,11 @@
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy2 0>;
+
+	fixed-link {
+		speed = <10000>;
+		full-duplex;
+	};
 };
 
 &cp0_eth1 {
-- 
2.17.0
