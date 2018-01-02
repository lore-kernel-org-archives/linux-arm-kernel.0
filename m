From: stefan@agner.ch (Stefan Agner)
Date: Tue,  2 Jan 2018 17:42:20 +0100
Subject: [PATCH 4/7] ARM: dts: imx6ul: add interrupt of virt-capable GIC
In-Reply-To: <20180102164223.15230-1-stefan@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
Message-ID: <20180102164223.15230-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A7 and its GIC support virtualization extensions. To
make use of them the CPU private interrupt needs to be specified.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1b14e4d39c26..993fbdbdd506 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -100,8 +100,10 @@
 
 	intc: interrupt-controller at a01000 {
 		compatible = "arm,gic-400", "arm,cortex-a7-gic";
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
+		interrupt-parent = <&intc>;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a02000 0x2000>,
 		      <0x00a04000 0x2000>,
-- 
2.15.1
