From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 5 Jun 2014 18:19:32 +0800
Subject: [PATCH 5/5] ARM: atmel: at91sam9n12ek: switch sound to CCF
In-Reply-To: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1401963572-10953-6-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the at91sam9n12ek has switch to CCF, so add clock for wm8904

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 64bbe46..8ae771d 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -56,6 +56,8 @@
 				wm8904: codec at 1a {
 					compatible = "wm8904";
 					reg = <0x1a>;
+					clocks = <&pck0>;
+					clock-names = "mclk";
 				};
 
 				qt1070: keyboard at 1b {
-- 
1.8.5.2
