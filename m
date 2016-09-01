From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Sep 2016 17:58:44 -0500
Subject: [PATCH 3/5] ARM: dts: keystone-k2e: Add MSM RAM node
In-Reply-To: <20160901225846.31058-1-s-anna@ti.com>
References: <20160901225846.31058-1-s-anna@ti.com>
Message-ID: <20160901225846.31058-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RAM managed by the Multicire Shared Memory Controller (MSMC)
as a mmio-sram node. The Keystone 2 Edison SoC has 2 MB of such
memory. Any specific MSM memory range needed by a software module
ought to be reserved using an appropriate child node.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 9a51b8c88581..48846c36cbed 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -46,6 +46,14 @@
 	soc {
 		/include/ "keystone-k2e-clocks.dtsi"
 
+		msm_ram: msmram at 0c000000 {
+			compatible = "mmio-sram";
+			reg = <0x0c000000 0x200000>;
+			ranges = <0x0 0x0c000000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usb: usb at 2680000 {
 			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
 			dwc3 at 2690000 {
-- 
2.9.3
