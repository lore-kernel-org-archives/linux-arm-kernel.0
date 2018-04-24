From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 24 Apr 2018 13:35:59 -0500
Subject: [PATCH 3/3] arm64: dts: stratix10: add sdram ecc
In-Reply-To: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1524594959-5259-4-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the Stratix10 ECC Manager and SDRAM EDAC nodes to the
device tree.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 76d5db4138b0..3a7da19216bb 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -924,6 +924,23 @@
 			status = "disabled";
 		};
 
+		eccmgr: eccmgr at ffd12000 {
+			compatible = "altr,socfpga-s10-ecc-manager";
+			altr,sysmgr-syscon = <&sysmgr>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <0 15 4>, <0 95 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ranges;
+
+			sdramedac at f8011100 {
+				compatible = "altr,sdram-edac-s10";
+				reg = <0xf8011100 0xC0>;
+				interrupts = <16 4>, <48 4>;
+			};
+		};
+
 		qspi: spi at ff8d2000 {
 			compatible = "cdns,qspi-nor";
 			#address-cells = <1>;
-- 
2.7.4
