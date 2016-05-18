From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 16:46:32 +0300
Subject: [PATCH 10/14] ARM: dts: omap4-duovero: Add pdmclk binding for audio
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1463579196-5484-11-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl6040 codec is generating the pdmclk, which is used by the McPDM as
functional clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-duovero.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index f2a94fa62552..a90b582e4c3f 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -177,6 +177,7 @@
 
 	twl6040: twl at 4b {
 		compatible = "ti,twl6040";
+		#clock-cells = <0>;
 		reg = <0x4b>;
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;		/* IRQ_SYS_2N cascaded to gic */
 		ti,audpwron-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;		/* gpio_160 */
@@ -207,6 +208,10 @@
 &mcpdm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcpdm_pins>;
+
+	clocks = <&twl6040>;
+	clock-names = "pdmclk";
+
 	status = "okay";
 };
 
-- 
2.8.2
