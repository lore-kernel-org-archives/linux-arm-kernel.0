From: richard.gong@linux.intel.com (richard.gong at linux.intel.com)
Date: Tue,  6 Nov 2018 10:52:49 -0600
Subject: [PATCHv10 5/8] arm64: dts: stratix10: add fpga manager and region
In-Reply-To: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
Message-ID: <1541523172-5171-6-git-send-email-richard.gong@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@kernel.org>

Add the Stratix10 FPGA manager and a FPGA region to the
device tree.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
v4: s/fpga-mgr at 0/fpga-mgr/ to remove unit_address
    add Richard's signed-off-by
v5: no change
v6: no change
v7: no change
v8: no change
v9: no change
v10: no change
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index a43ed05..62550a1 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -106,6 +106,14 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
 		clkmgr: clock-controller at ffd10000 {
 			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
@@ -553,6 +561,10 @@
 				compatible = "intel,stratix10-svc";
 				method = "smc";
 				memory-region = <&service_reserved>;
+
+				fpga_mgr: fpga-mgr {
+					compatible = "intel,stratix10-soc-fpga-mgr";
+				};
 			};
 		};
 	};
-- 
2.7.4
