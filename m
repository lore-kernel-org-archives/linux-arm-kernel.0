From: manish.narani@xilinx.com (Manish Narani)
Date: Tue, 18 Sep 2018 19:15:39 +0530
Subject: [RFC PATCH 4/4] arm64: zynqmp: Add new SDHCI compatible string
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1537278339-9257-5-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainline kernel has arasan compatible string now. Append this new
compatible string for ZynqMP SDHCI controller. Also add a required
property indicating ZynqMP SDHCI controller device ID.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..1def7e1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -485,21 +485,23 @@
 		};
 
 		sdhci0: sdhci at ff160000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			xlnx,device_id = <0>;
 		};
 
 		sdhci1: sdhci at ff170000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			xlnx,device_id = <1>;
 		};
 
 		smmu: smmu at fd800000 {
-- 
2.1.1
