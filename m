From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Sep 2016 17:58:45 -0500
Subject: [PATCH 4/5] ARM: dts: keystone-k2g: Add MSM RAM node
In-Reply-To: <20160901225846.31058-1-s-anna@ti.com>
References: <20160901225846.31058-1-s-anna@ti.com>
Message-ID: <20160901225846.31058-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RAM managed by the Multicore Shared Memory Controller (MSMC)
as a mmio-sram node. The Keystone 2 K2G SoC has 1 MB of such memory.
Any specific MSM memory range needed by a software module ought to
be reserved using an appropriate child node.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 3372615b885c..be1db22db0d3 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -76,6 +76,14 @@
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
+		msm_ram: msmram at 0c000000 {
+			compatible = "mmio-sram";
+			reg = <0x0c000000 0x100000>;
+			ranges = <0x0 0x0c000000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		k2g_pinctrl: pinmux at 02621000 {
 			compatible = "pinctrl-single";
 			reg = <0x02621000 0x410>;
-- 
2.9.3
