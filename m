From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:27 +0200
Subject: [RFC 3/8] ARM: Kirkwood: Update sound DT node to reflect DPCM support
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that kirkwood-i2s supports multiple DAIs, we need to specify which
DAI is to be used in phandle. So increase the #sound-dai-cells to one.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index afc640cd80c5..69b4cee1f4d3 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -372,7 +372,7 @@
 
 		audio0: audio-controller at a0000 {
 			compatible = "marvell,kirkwood-audio";
-			#sound-dai-cells = <0>;
+			#sound-dai-cells = <1>;
 			reg = <0xa0000 0x2210>;
 			interrupts = <24>;
 			clocks = <&gate_clk 9>;
-- 
2.0.1
