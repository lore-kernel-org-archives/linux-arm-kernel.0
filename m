From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:53 +0300
Subject: [PATCH v2 4/8] arm: dts: lpc32xx: add device node for the second pwm
 controller
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPC32xx SoCs have two independent PWM controllers, they have different
clock parents, clock gates and even slightly different controls,
each of these two PWM controllers has one output channel. Due to
almost similar controls arranged in a row it is incorrectly assumed
that there is one PWM controller with two channels, fix this problem
in lpc32xx.dtsi, which at the moment prevents separate configuration
of different clock parents and gates for both PWM controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- none

 arch/arm/boot/dts/lpc32xx.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index fb0e9ae..be82992 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -290,9 +290,15 @@
 				status = "disabled";
 			};
 
-			pwm: pwm at 4005C000 {
+			pwm1: pwm at 4005C000 {
 				compatible = "nxp,lpc3220-pwm";
-				reg = <0x4005C000 0x8>;
+				reg = <0x4005C000 0x4>;
+				status = "disabled";
+			};
+
+			pwm2: pwm at 4005C004 {
+				compatible = "nxp,lpc3220-pwm";
+				reg = <0x4005C004 0x4>;
 				status = "disabled";
 			};
 		};
-- 
2.1.4
