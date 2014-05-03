From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:17 +0200
Subject: [PATCH v2 7/9] ARM: Kirkwood: t5325: Use simple card to instantiate
 audio
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree nodes to instantiate the audio drivers on the HP T5325
device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-t5325.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index dbb730642543..caedc9f1e69b 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -192,6 +192,31 @@
 		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Speaker", "SPKOUT",
+			"Speaker", "SPKOUTN",
+			"MIC1", "Mic Jack",
+			"MIC2", "Mic Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker",
+			"Microphone", "Mic Jack";
+
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&audio>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&alc5621>;
+		};
+	};
 };
 
 &mdio {
-- 
2.0.0.rc0
