From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 7 Mar 2016 17:17:33 +0200
Subject: [PATCH v2 06/10] ARM: DTS: am57xx-beagle-x15: Move clkout2 source
 selection to codec node
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457363857-20797-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The assigned-clock* needs to be in the root of the device's node. If it is
in the sub-node the CCF will ignore it.
Since the clkout2 is used by the codec as MCLK, move the clock parent
selection to that node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 0a5fc5d02ce2..2bbc8ae00ada 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -173,8 +173,6 @@
 
 		sound0_master: simple-audio-card,codec {
 			sound-dai = <&tlv320aic3104>;
-			assigned-clocks = <&clkoutmux2_clk_mux>;
-			assigned-clock-parents = <&sys_clk2_dclk_div>;
 			clocks = <&clkout2_clk>;
 		};
 	};
@@ -584,6 +582,9 @@
 		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&clkout2_pins_default>;
 		pinctrl-1 = <&clkout2_pins_sleep>;
+		assigned-clocks = <&clkoutmux2_clk_mux>;
+		assigned-clock-parents = <&sys_clk2_dclk_div>;
+
 		status = "okay";
 		adc-settle-ms = <40>;
 
-- 
2.7.2
