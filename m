From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 16:46:28 +0300
Subject: [PATCH 06/14] ARM: dts: omap5-board-common: Add pdmclk binding for
 audio
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1463579196-5484-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl6040 codec is generating the pdmclk, which is used by the McPDM as
functional clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 19efaa079797..63d0352d068d 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -637,6 +637,7 @@
 
 	twl6040: twl at 4b {
 		compatible = "ti,twl6040";
+		#clock-cells = <0>;
 		reg = <0x4b>;
 
 		pinctrl-names = "default";
@@ -658,6 +659,10 @@
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
