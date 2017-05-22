From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:52 +0800
Subject: [PATCH 6/6] ARM: sun8i: a83t: cubietruck-plus: Enable SPDIF output
In-Reply-To: <20170522062552.19026-1-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
Message-ID: <20170522062552.19026-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck Plus has an optical SPDIF out connector.
Enable SPDIF audio output for this board.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 9e10cc6f39d4..cff33454fc24 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -82,6 +82,28 @@
 			gpios = <&pio 4 4 GPIO_ACTIVE_HIGH>; /* PE4 */
 		};
 	};
+
+	sound {
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
+};
+
+&spdif {
+	status = "okay";
 };
 
 &uart0 {
-- 
2.11.0
