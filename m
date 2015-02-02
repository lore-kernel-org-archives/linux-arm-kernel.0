From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Feb 2015 14:51:47 +0800
Subject: [PATCH 4/4] ARM: at91: dt: sama5d4ek: enable audio
In-Reply-To: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
References: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422859907-14881-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable audio support for sama5d4ek board.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d4ek.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 7f47d92..0df5f1b 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -190,6 +190,10 @@
 						atmel,pins =
 							<AT91_PIOE 13 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PE13 gpio */
 					};
+					pinctrl_pck2_as_audio_mck: pck2_as_audio_mck {
+						atmel,pins =
+							<AT91_PIOB 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+					};
 				};
 			};
 		};
@@ -268,4 +272,20 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	sound {
+		compatible = "atmel,asoc-wm8904";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pck2_as_audio_mck>;
+
+		atmel,model = "wm8904 @ SAMA5D4EK";
+		atmel,audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN1L", "Line In Jack",
+			"IN1R", "Line In Jack";
+
+		atmel,ssc-controller = <&ssc0>;
+		atmel,audio-codec = <&wm8904>;
+	};
 };
-- 
2.3.0.rc0
