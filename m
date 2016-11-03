From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Nov 2016 13:41:41 +0100
Subject: [PATCH] ARM: gr8: evb: Enable SPDIF
Message-ID: <20161103124141.4529-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GR8-EVB has a SPDIF out connector. Enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/ntc-gr8-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
index 4b622f3b5220..e3b7a6273c61 100644
--- a/arch/arm/boot/dts/ntc-gr8-evb.dts
+++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
@@ -75,6 +75,24 @@
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
 	};
+
+	spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &be0 {
-- 
2.10.1
