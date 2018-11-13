From: richard.gong@linux.intel.com (richard.gong at linux.intel.com)
Date: Tue, 13 Nov 2018 12:14:00 -0600
Subject: [PATCHv11 2/8] arm64: dts: stratix10: add stratix10 service driver
 binding to base dtsi
In-Reply-To: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
References: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
Message-ID: <1542132846-24168-3-git-send-email-richard.gong@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Gong <richard.gong@intel.com>

Add Intel Stratix10 service layer to the device tree

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: change to put service layer driver node under the firmware node
    change compatible to "intel, stratix10-svc"
v3: no change
v4: s/service driver/stratix10 service driver/ in subject line
v5: no change
v6: add Moritz's Acked-by
v7: no change
v8: no change
v9: no change
v10: no change
v11: no change
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index fef7351..519b16e 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -24,6 +24,19 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer at 0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -537,5 +550,13 @@
 
 			status = "disabled";
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
 	};
 };
-- 
2.7.4
