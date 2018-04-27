From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 27 Apr 2018 13:37:18 -0500
Subject: [PATCHv2 3/3] arm64: dts: stratix10: add sdram ecc
In-Reply-To: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
References: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1524854238-19394-4-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the Stratix10 ECC Manager and SDRAM EDAC nodes to the
device tree.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Remove unused SysMan syscon
    Remove unused SDRAM ECC register defines
    Remove unused address, size and range from device tree.
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index c89d0c307f8d..688391f3bf78 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -387,5 +387,17 @@
 			resets = <&rst WATCHDOG3_RESET>;
 			status = "disabled";
 		};
+
+		eccmgr {
+			compatible = "altr,socfpga-s10-ecc-manager";
+			interrupts = <0 15 4>, <0 95 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			sdramedac {
+				compatible = "altr,sdram-edac-s10";
+				interrupts = <16 4>, <48 4>;
+			};
+		};
 	};
 };
-- 
2.7.4
