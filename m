From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Tue, 26 Apr 2016 12:54:29 -0500
Subject: [PATCH 3/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
In-Reply-To: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Message-ID: <1461693269-19436-4-git-send-email-Linux.HWI@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This commit updates the OSC_32K_CLK (secure_32k_clk_src_ck) frequency
from the precise 32kHz frequency (i.e., 32.768 kHz) to the more
accurate frequency of ~34.6 kHz. Actual measured frequencies of the
clock vary from board to board anywhere from 34.4 kHz up to 34.8 kHz.

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index a514fc3..4501140 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -95,7 +95,7 @@
 	secure_32k_clk_src_ck: secure_32k_clk_src_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		clock-frequency = <32768>;
+		clock-frequency = <34600>; /* approximate frequency */
 	};
 
 	virt_12000000_ck: virt_12000000_ck {
-- 
1.9.1
