From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:35 +0100
Subject: [PATCH 14/14] ARM: ux500: allow Snowball access to the AB8500 GPIO
 pins
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-15-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The AB8500 GPIO driver has been un-BROKEN and rewritten as a pinctrl
driver. Now that it's back in use, let's ensure that it's available
when booting Snowball with Device Tree enabled.

Cc: arm at kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Requesting an ACK from the ARM SoC maintainers on this patch.
---
 arch/arm/boot/dts/snowball.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 27f31a5..b095e85 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -299,6 +299,10 @@
 			};
 
 			ab8500 at 5 {
+				ab8500-gpio {
+					compatible = "stericsson,ab8500-gpio";
+				};
+
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
-- 
1.7.11.3
