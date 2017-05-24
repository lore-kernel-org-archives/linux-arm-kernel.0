From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 24 May 2017 16:10:32 +0200
Subject: [PATCH v6 2/5] arm64: marvell: dts: fix interrupts in 7k/8k crypto
 nodes
In-Reply-To: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
References: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
Message-ID: <20170524141035.21031-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cryptographic engine nodes have an interrupt which is configured as
both edge and level, which makes no sense at all. Fix this by
configuring it the right way (level).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ac8df5201cd6..b4bc42ece754 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -231,8 +231,7 @@
 			cpm_crypto: crypto at 800000 {
 				compatible = "inside-secure,safexcel-eip197";
 				reg = <0x800000 0x200000>;
-				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
-				| IRQ_TYPE_LEVEL_HIGH)>,
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 7740a75a8230..6e2058847ddc 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -221,8 +221,7 @@
 			cps_crypto: crypto at 800000 {
 				compatible = "inside-secure,safexcel-eip197";
 				reg = <0x800000 0x200000>;
-				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
-				| IRQ_TYPE_LEVEL_HIGH)>,
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.9.4
