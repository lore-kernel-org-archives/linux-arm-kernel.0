From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  7 Nov 2016 14:08:21 +0100
Subject: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
In-Reply-To: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GR8-EVB comes with a wm8978 codec connected to the i2s bus.

Add a card in order to have it working

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
index 12b4317a4383..5291e425caf9 100644
--- a/arch/arm/boot/dts/ntc-gr8-evb.dts
+++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
@@ -76,6 +76,20 @@
 		default-brightness-level = <8>;
 	};
 
+	i2s {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "gr8-evb-wm8978";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <512>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8978>;
+		};
+	};
 
 	panel {
 		compatible = "allwinner,sun4i-a10-sub-evb-5-lcd";
-- 
git-series 0.8.11
