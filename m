From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:14 +0200
Subject: [PATCH v2 4/9] ARM: Kirkwood: DT: Add missing #sound-dai-cells
 property
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sound node is missing a #sound-dai-cells property. Add it, so that
the sounds node can be used in combination with the simple-audio-card
binding.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 90384587c278..919d1f7f2eef 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -314,6 +314,7 @@
 
 		audio0: audio-controller at a0000 {
 			compatible = "marvell,kirkwood-audio";
+			#sound-dai-cells = <0>;
 			reg = <0xa0000 0x2210>;
 			interrupts = <24>;
 			clocks = <&gate_clk 9>;
-- 
2.0.0.rc0
