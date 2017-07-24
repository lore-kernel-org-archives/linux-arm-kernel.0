From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 24 Jul 2017 15:48:44 +0200
Subject: [PATCH net-next 14/18] arm64: dts: marvell: cp110: add PPv2 port
 interrupts
In-Reply-To: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
Message-ID: <20170724134848.19330-15-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ports interrupts are used by the PPv2 driver when no PHY is connected to
a port. This patch adds a description of these interrupts.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

@Dave: Hi! This patch should go through the mvebu tree. Thanks!

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 15 +++++++++------
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 15 +++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 13763eefeb6e..ebbdb3c97b7f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -69,24 +69,27 @@
 				dma-coherent;
 
 				cpm_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cpm_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cpm_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 0382cffef189..a9ac5fc6def7 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -76,24 +76,27 @@
 				dma-coherent;
 
 				cps_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cps_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cps_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "rx-shared";
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "rx-shared", "link";
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
-- 
2.13.3
