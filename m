From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:54 +0100
Subject: [PATCH v2 4/8] arm64: dts: marvell: fix compatible string list for
 Armada CP110 slave NAND
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-5-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada CP110 slave NAND controller Device Tree description lists
the compatible string in the wrong order: marvell,armada-8k-nand
should come first. This commit alignes the slave CP110 description
with the master CP110 description from that respect.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 0624ec2de496..3eda62d482fc 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -322,8 +322,8 @@
 				 * this controller is only usable on the CPM
 				 * for A7K and on the CPS for A8K.
 				 */
-				compatible = "marvell,armada370-nand",
-					     "marvell,armada-8k-nand";
+				compatible = "marvell,armada-8k-nand",
+					     "marvell,armada370-nand";
 				reg = <0x720000 0x54>;
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.14.3
