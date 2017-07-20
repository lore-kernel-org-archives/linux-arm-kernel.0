From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:09 +0200
Subject: [PATCH 10/10] arm64: zynqmp: Set status disabled in dtsi
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <e3533d223e5a6a1b39d401cc6ec4b481a8b60398.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

Do not enable smmu via dtsi. Enable it in board file when needed.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9304249a23ed..787463796348 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -339,6 +339,7 @@
 		smmu: smmu at fd800000 {
 			compatible = "arm,mmu-500";
 			reg = <0x0 0xfd800000 0x0 0x20000>;
+			status = "disabled";
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
 			interrupts = <0 155 4>,
-- 
1.9.1
