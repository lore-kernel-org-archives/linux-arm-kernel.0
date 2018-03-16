From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:49 +0100
Subject: [PATCH net-next 08/10] arm64: dts: marvell: 7040-db: set the 10G
 interface management to in-band
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-9-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the 10G interface (cp0_eth0) management to in-band. This
is needed for the PPv2 driver to handle such ports, with its conversion
to phylink.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 3ae05eee2c9a..f27af07db381 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -267,6 +267,7 @@
 	status = "okay";
 	/* Network PHY */
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy2 0>;
 };
-- 
2.14.3
