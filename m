From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 29 May 2018 13:13:31 -0500
Subject: [PATCH 1/2] arm64: dts: stratix10: Fix SPI nodes for Stratix10
Message-ID: <1527617612-2205-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Remove the unused bus-num node and change num-chipselect
to num-cs to match SPI bindings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Fixes: 78cd6a9d8e154 ("arm64: dts: Add base stratix 10 dtsi")
Cc: stable at vger.kernel.org
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index d8c94d5ff4b4..47fa4b450324 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -315,8 +315,7 @@
 			interrupts = <0 99 4>;
 			resets = <&rst SPIM0_RESET>;
 			reg-io-width = <4>;
-			num-chipselect = <4>;
-			bus-num = <0>;
+			num-cs = <4>;
 			status = "disabled";
 		};
 
@@ -328,8 +327,7 @@
 			interrupts = <0 100 4>;
 			resets = <&rst SPIM1_RESET>;
 			reg-io-width = <4>;
-			num-chipselect = <4>;
-			bus-num = <0>;
+			num-cs = <4>;
 			status = "disabled";
 		};
 
-- 
2.7.4
