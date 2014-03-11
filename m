From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Mar 2014 14:24:18 -0700
Subject: [PATCH] ARM: dts: msm8974: Move arch-timer out of soc node
Message-ID: <1394573058-18561-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The architected timer is not a register addressable piece of
hardware. Instead it's accessed through cp15 accessors. Move it
to the root of the devicetree to reflect this.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 9d79b98f18bb..d3fe0c21c6f4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -52,6 +52,15 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 2 0xf08>,
+			     <1 3 0xf08>,
+			     <1 4 0xf08>,
+			     <1 1 0xf08>;
+		clock-frequency = <19200000>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -66,15 +75,6 @@
 			      <0xf9002000 0x1000>;
 		};
 
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <1 2 0xf08>,
-				     <1 3 0xf08>,
-				     <1 4 0xf08>,
-				     <1 1 0xf08>;
-			clock-frequency = <19200000>;
-		};
-
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
