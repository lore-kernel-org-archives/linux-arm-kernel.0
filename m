From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Feb 2015 14:51:46 +0800
Subject: [PATCH 3/4] ARM: at91: dt: sama5d4ek: add and enable wm8904
In-Reply-To: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
References: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422859907-14881-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wm8904 codec node and enable it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d4ek.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 32e9a9a..7f47d92 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -131,6 +131,13 @@
 
 			i2c0: i2c at f8014000 {
 				status = "okay";
+
+				wm8904: codec at 1a {
+					compatible = "wlf,wm8904";
+					reg = <0x1a>;
+					clocks = <&pck2>;
+					clock-names = "mclk";
+				};
 			};
 
 			macb0: ethernet at f8020000 {
-- 
2.3.0.rc0
