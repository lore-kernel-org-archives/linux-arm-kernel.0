From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 24 Apr 2014 18:53:50 +0200
Subject: [PATCH 1/1] ARM: dts: omap3-igep0020: use SMSC9221 timings
Message-ID: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IGEPv2 board has a SMSC LAN9221i ethernet chip and not a
SMSC LAN911x connected to the GPMC. Each chip needs different
timings in order to operate correctly so is wrong to include
omap-gpmc-smsc911x.dtsi instead of omap-gpmc-smsc9221.dtsi.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hi Tony,

I see no performance difference when measuring network throughput using
iperf(1) but this change is the correct one nonetheless since if we later
better adjust the timings it will already include the right dtsi.

Best regards,
Javier

 arch/arm/boot/dts/omap3-igep.dtsi    | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index b97736d..e2d163b 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -107,7 +107,7 @@
 		>;
 	};
 
-	smsc911x_pins: pinmux_smsc911x_pins {
+	smsc9221_pins: pinmux_smsc9221_pins {
 		pinctrl-single,pins = <
 			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
 		>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 7abd64f..b22caaa 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -10,7 +10,7 @@
  */
 
 #include "omap3-igep.dtsi"
-#include "omap-gpmc-smsc911x.dtsi"
+#include "omap-gpmc-smsc9221.dtsi"
 
 / {
 	model = "IGEPv2 (TI OMAP AM/DM37x)";
@@ -248,7 +248,7 @@
 
 	ethernet at gpmc {
 		pinctrl-names = "default";
-		pinctrl-0 = <&smsc911x_pins>;
+		pinctrl-0 = <&smsc9221_pins>;
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
-- 
1.9.1
