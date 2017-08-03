From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:48 +0200
Subject: [PATCH 2/5] arm64: zynqmp: Use C pre-processor for includes
In-Reply-To: <cover.1501760202.git.michal.simek@xilinx.com>
References: <cover.1501760202.git.michal.simek@xilinx.com>
Message-ID: <0226364dd21172af666230f66390c23254df5b48.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alistair Francis <alistair.francis@xilinx.com>

Change the dtsi include code to use the C pre-processor #include instead
of the device tree /include/. This enables option to use dt binding
headers.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index ee7fa27e1e23..fba8f049769b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -13,8 +13,8 @@
 
 /dts-v1/;
 
-/include/ "zynqmp.dtsi"
-/include/ "zynqmp-ep108-clk.dtsi"
+#include "zynqmp.dtsi"
+#include "zynqmp-ep108-clk.dtsi"
 
 / {
 	model = "ZynqMP EP108";
-- 
1.9.1
