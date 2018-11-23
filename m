From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:56 +0100
Subject: [PATCH 7/7] ARM64: dts: marvell: armada-3720-espressobin: declare
 SATA PHY property
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Message-ID: <20181123101556.29888-8-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SATA node is wired to the third PHY of the COMPHY IP.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 3ab25ad402b9..e947ef61d946 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -51,6 +51,8 @@
 /* J6 */
 &sata {
 	status = "okay";
+	phys = <&comphy2 0>;
+	phy-names = "sata-phy";
 };
 
 /* J1 */
-- 
2.19.1
