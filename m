From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 30 May 2016 11:55:16 +0300
Subject: [PATCH v1 08/14] ARM: dts: omap4-sdp: Add pdmclk binding for audio
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Message-ID: <20160530085522.30398-9-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl6040 codec is generating the pdmclk, which is used by the McPDM as
functional clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index aae513265dc2..7e6cd2d8ed5d 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -367,6 +367,7 @@
 
 	twl6040: twl at 4b {
 		compatible = "ti,twl6040";
+		#clock-cells = <0>;
 		reg = <0x4b>;
 
 		pinctrl-names = "default";
@@ -620,6 +621,10 @@
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
2.8.3
