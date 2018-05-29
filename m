From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 29 May 2018 13:13:32 -0500
Subject: [PATCH 2/2] arm64: dts: stratix10: Add SPI clocks for Stratix10
In-Reply-To: <1527617612-2205-1-git-send-email-thor.thayer@linux.intel.com>
References: <1527617612-2205-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1527617612-2205-2-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the SPI clocks to the Stratix10 device tree.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 47fa4b450324..34658f135daf 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -316,6 +316,8 @@
 			resets = <&rst SPIM0_RESET>;
 			reg-io-width = <4>;
 			num-cs = <4>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>,
+				 <&clkmgr STRATIX10_SPI_M_CLK>;
 			status = "disabled";
 		};
 
@@ -328,6 +330,8 @@
 			resets = <&rst SPIM1_RESET>;
 			reg-io-width = <4>;
 			num-cs = <4>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>,
+				 <&clkmgr STRATIX10_SPI_M_CLK>;
 			status = "disabled";
 		};
 
-- 
2.7.4
