From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 30 Jul 2013 11:59:49 +0200
Subject: [PATCH v6 5/8] ARM: AT91: DTS: sam9x5ek: add WM8731 codec
In-Reply-To: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
References: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1375178392-26060-6-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WM8731 codec on sam9x5ek board is on i2c, address 1A

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index d107241..e6fb309 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -59,6 +59,11 @@
 
 			i2c0: i2c at f8010000 {
 				status = "okay";
+
+				wm8731: wm8731 at 1a {
+					compatible = "wm8731";
+					reg = <0x1a>;
+				};
 			};
 
 			pinctrl at fffff400 {
-- 
1.7.10.4
