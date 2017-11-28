From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:02:30 +0000
Subject: [PATCH v2 07/16] ARM: dts: imx6qdl-sr-som-brcm: rename sdio clock
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhP4-0006Nk-PT@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDIO clock is really the Broadcom clock.  Rename it as such.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
index 809d7896775c..b55af61dfeca 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
@@ -40,7 +40,7 @@
  */
 #include <dt-bindings/gpio/gpio.h>
 / {
-	clk_sdio: sdio-clock {
+	clk_brcm: brcm-clock {
 		compatible = "gpio-gate-clock";
 		#clock-cells = <0>;
 		pinctrl-names = "default";
@@ -64,7 +64,7 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>,
 			      <&gpio6 0 GPIO_ACTIVE_LOW>;
-		clocks = <&clk_sdio>;
+		clocks = <&clk_brcm>;
 		clock-names = "ext_clock";
 	};
 };
-- 
2.7.4
