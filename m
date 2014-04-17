From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 17:53:12 +0200
Subject: [PATCH 3/5] ARM: Kirkwood: DT: Add missing #sound-dai-cells property
In-Reply-To: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397749994-24983-4-git-send-email-andrew@lunn.ch>
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
1.9.2
