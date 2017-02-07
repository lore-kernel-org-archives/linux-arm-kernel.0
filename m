From: lis8215@gmail.com (lis8215 at gmail.com)
Date: Tue,  7 Feb 2017 20:50:46 +0300
Subject: [PATCH v2 4/4] ARM: dts: sun6i: Add the PWM block to the A31/A31s.
In-Reply-To: <1486489846-662-1-git-send-email-lis8215@gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
Message-ID: <1486489846-662-5-git-send-email-lis8215@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Siarhei Volkau <lis8215@gmail.com>

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ee1eb6d..fcba129 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -627,6 +627,14 @@
 			status = "disabled";
 		};
 
+		pwm: pwm at 01c21400 {
+			compatible = "allwinner,sun6i-a31-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.4.11
