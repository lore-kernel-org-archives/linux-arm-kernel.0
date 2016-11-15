From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 15 Nov 2016 15:04:42 +0100
Subject: [PATCH] ARM64: zynqmp: Fix W=1 dtc 1.4 warnings
Message-ID: <1e8f8f0f369b6838bf995e7369bb364c3020a411.1479218678.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch removes these warnings reported by dtc 1.4:
Warning (unit_address_vs_reg): Node /amba_apu has a reg or ranges
property, but no unit name
Warning (unit_address_vs_reg): Node /memory has a reg or ranges
property, but no unit name

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 358089687a69..ef1b9e573af0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -27,7 +27,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 68a908334c7b..83791eadff41 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -72,7 +72,7 @@
 			     <1 10 0xf08>;
 	};
 
-	amba_apu {
+	amba_apu: amba_apu at 0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
1.9.1
