From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 23 May 2014 14:57:53 +0100
Subject: [RFC v2 05/10] ARM: STi: STiH41x: Extend UART with FIQ support.
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1400853478-5824-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the UART with a second interrupt resource that
can be used to route the UARTs interrupt to FIQ (demarked by setting
bit 7 in the third item in the tuple).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: kernel at stlinux.com
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/stih415.dtsi | 4 ++--
 arch/arm/boot/dts/stih416.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d89064c..b2c9df4 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -79,7 +79,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfed32000 0x2c>;
-			interrupts	= <0 197 0>;
+			interrupts	= <0 197 0>, <0 197 0x80>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_serial2>;
 			clocks		= <&CLKS_ICN_REG_0>;
@@ -90,7 +90,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
-			interrupts	= <0 210 0>;
+			interrupts	= <0 210 0>, <0 197 0x80>;
 			clocks		= <&CLK_SYSIN>;
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_sbc_serial1>;
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..fdf7b43 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -88,7 +88,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfed32000 0x2c>;
-			interrupts	= <0 197 0>;
+			interrupts	= <0 197 0>, <0 210 0x80>;
 			clocks          = <&CLK_S_ICN_REG_0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_serial2 &pinctrl_serial2_oe>;
@@ -99,7 +99,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
-			interrupts	= <0 210 0>;
+			interrupts	= <0 210 0>, <0 210 0x80>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
 			clocks          = <&CLK_SYSIN>;
-- 
1.9.0
