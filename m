From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Jan 2018 09:21:02 +0100
Subject: [PATCH 2/7] ARM: dts: STi: Add gpio polarity for "hdmi,
 hpd-gpio" property
In-Reply-To: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515572469-19276-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

The GPIO polarity is missing in the hdmi,hpd-gpio property, this
fixes the following DT warnings:

arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000

arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000

arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407.dtsi | 3 ++-
 arch/arm/boot/dts/stih410.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index fa14983..11fdecd 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-clock.dtsi"
 #include "stih407-family.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	soc {
 		sti-display-subsystem {
@@ -122,7 +123,7 @@
 					 <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3>;
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
 				reset-names = "hdmi";
 				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 				ddc = <&hdmiddc>;
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 07b02a3..e4b7e3d 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -9,6 +9,7 @@
 #include "stih410-clock.dtsi"
 #include "stih407-family.dtsi"
 #include "stih410-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	aliases {
 		bdisp0 = &bdisp0;
@@ -213,7 +214,7 @@
 					 <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3>;
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
 				reset-names = "hdmi";
 				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 				ddc = <&hdmiddc>;
-- 
1.9.1
