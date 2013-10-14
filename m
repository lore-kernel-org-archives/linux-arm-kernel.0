From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 14 Oct 2013 13:38:31 +0800
Subject: [PATCH 3/5] ARM: at91: enable wm8904 on at91sam9n12ek board
In-Reply-To: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
References: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1381729113-29714-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wm8904 codec on at91sam9n12ek board, which is connect
to i2c0 bus with 0x1a as address.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 27a9352..1ba8def 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -41,6 +41,11 @@
 			i2c0: i2c at f8010000 {
 				status = "okay";
 
+				wm8904: codec at 1a {
+					compatible = "wm8904";
+					reg = <0x1a>;
+				};
+
 				qt1070: keyboard at 1b {
 					compatible = "qt1070";
 					reg = <0x1b>;
-- 
1.7.9.5
