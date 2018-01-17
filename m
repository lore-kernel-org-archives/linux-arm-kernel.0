From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:46 +0100
Subject: [PATCH 2/6] arm64: zynqmp: Fix alignment in dts files
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <b80ef4af56de3bd47bb6d45ba91b4150965506cd.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial changes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index bf552674a834..fe7c48b6fa78 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -47,7 +47,7 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: phy at 0{
+	phy0: phy at 0 {
 		reg = <0>;
 		max-speed = <100>;
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 0da98007753b..9ca4d1f83b51 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -439,10 +439,10 @@
 			device_type = "pci";
 			interrupt-parent = <&gic>;
 			interrupts = <0 118 4>,
-				    <0 117 4>,
-				    <0 116 4>,
-				    <0 115 4>,	/* MSI_1 [63...32] */
-				    <0 114 4>;	/* MSI_0 [31...0] */
+				     <0 117 4>,
+				     <0 116 4>,
+				     <0 115 4>,	/* MSI_1 [63...32] */
+				     <0 114 4>;	/* MSI_0 [31...0] */
 			interrupt-names = "misc", "dummy", "intx",
 					  "msi1", "msi0";
 			msi-parent = <&pcie>;
-- 
1.9.1
