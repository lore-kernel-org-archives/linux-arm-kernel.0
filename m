From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Wed, 14 Nov 2012 13:59:45 +0100
Subject: [PATCH 2/2] ARM: LPC32xx: Add the motor PWM to base dts file
In-Reply-To: <1352897985-15419-1-git-send-email-alban.bedel@avionic-design.de>
References: <1352897985-15419-1-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <1352897985-15419-3-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 arch/arm/boot/dts/lpc32xx.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index ef0fdc7..a1e6a9b 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -182,6 +182,13 @@
 				pnx,timeout = <0x64>;
 			};
 
+			mpwm: mpwm at 400E8000 {
+				compatible = "nxp,lpc3220-motor-pwm";
+				reg = <0x400E8000 0x78>;
+				status = "disabled";
+				#pwm-cells = <2>;
+			};
+
 			i2cusb: i2c at 31020300 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x31020300 0x100>;
-- 
1.7.0.4
