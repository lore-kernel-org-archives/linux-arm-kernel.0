From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 22:53:02 +0200
Subject: [PATCH 09/13] ARM: sun7i: Add sunxi codec device node
In-Reply-To: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445460786-18280-10-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

The A20 SoC includes the Allwinner audio codec, capable of both 24-bit
playback and capture. This commit adds a device node for it.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f4440f6d9621..e02eb720c4fc 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1216,6 +1216,19 @@
 			status = "disabled";
 		};
 
+		codec: codec at 01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun7i-a20-codec";
+			reg = <0x01c22c00 0x40>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 0>, <&codec_clk>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 19>,
+			       <&dma SUN4I_DMA_NORMAL 19>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
2.6.2
