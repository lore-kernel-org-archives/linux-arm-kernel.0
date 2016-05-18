From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 16:46:29 +0300
Subject: [PATCH 07/14] ARM: dts: omap4-panda-common: Add pdmclk binding for
 audio
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1463579196-5484-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl6040 codec is generating the pdmclk, which is used by the McPDM as
functional clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index df2e356ec089..e1d606f64cb7 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -376,6 +376,7 @@
 
 	twl6040: twl at 4b {
 		compatible = "ti,twl6040";
+		#clock-cells = <0>;
 		reg = <0x4b>;
 
 		pinctrl-names = "default";
@@ -479,6 +480,10 @@
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
