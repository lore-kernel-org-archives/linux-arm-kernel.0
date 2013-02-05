From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:34 +0100
Subject: [PATCH 13/14] ARM: ux500: enable AB8500 GPIO for HREF
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-14-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The AB8500 GPIO driver has been un-BROKEN and rewritten as a pinctrl
driver. Now that it's back in use, let's ensure that it's available
when booting HREF with Device Tree enabled.

Cc: arm at kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Requesting an ACK from the ARM SoC maintainers on this patch.
---
 arch/arm/boot/dts/hrefprev60.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index eec29c4..0c2b975 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -25,6 +25,14 @@
 	};
 
 	soc-u9500 {
+		prcmu at 80157000 {
+			ab8500 at 5 {
+				ab8500-gpio {
+					compatible = "stericsson,ab8500-gpio";
+				};
+			};
+		};
+
 		i2c at 80004000 {
 			tps61052 at 33 {
 				compatible = "tps61052";
-- 
1.7.11.3
