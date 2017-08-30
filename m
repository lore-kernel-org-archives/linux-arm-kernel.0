From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Aug 2017 11:07:45 +0200
Subject: [PATCH] arm64: dts: marvell: add TX interrupts for PPv2.2
Message-ID: <20170830090745.24559-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Marvell Armada 7K/8K Device Tree to describe
the TX interrupts of the Ethernet controllers, in both the master and
slave CP110s.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This DT change comes together with a number of changes that have been
merged in net-next for the mvpp2 driver. It was originally part of the
mvpp2 series, but because it was confusing Dave Miller to have driver
and DT changes in the same patch series, I removed the DT changes from
the series, and then forgot to send them again due to vacations.

It would be really nice to have these changes in 4.14, otherwise the
driver changes are somewhat useless :-/

 .../boot/dts/marvell/armada-cp110-master.dtsi      | 24 +++++++++++++++++++---
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 24 +++++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 8b019a9..0bfd4f8 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -69,21 +69,39 @@
 				dma-coherent;
 
 				cpm_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cpm_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cpm_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 7c11001..a020e10 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -69,21 +69,39 @@
 				dma-coherent;
 
 				cps_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cps_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cps_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+							  "tx-cpu3", "rx-shared";
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
-- 
2.9.4
