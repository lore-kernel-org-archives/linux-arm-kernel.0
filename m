From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:08 +0200
Subject: [PATCH 09/10] arm64: zynqmp: Add new uartps compatible string
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <4babfd9b8311073566a5d5730353c035bb5afa2a.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainline kernel has r1p12 compatible string now. Use this new compatible
string and also append generic compatible string.
Keep in your mind that using this generic compatible string not all uart
features will be available.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 4adf5285f56d..9304249a23ed 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -407,7 +407,7 @@
 		};
 
 		uart0: serial at ff000000 {
-			compatible = "cdns,uart-r1p8";
+			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 21 4>;
@@ -416,7 +416,7 @@
 		};
 
 		uart1: serial at ff010000 {
-			compatible = "cdns,uart-r1p8";
+			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 22 4>;
-- 
1.9.1
