From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:45 +0200
Subject: [PATCH 27/32] ARM: ux500: Add all known I2C sub-device nodes to the
 HREF DT
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-28-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the skeleton nodes for each of the known I2C sub-devices
currently registered on ST-Ericsson's HREF Development Platform. We
will fill these nodes in turn as the drivers are enabled for Device
Tree.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 32cd7a0..1d2c642 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -32,5 +32,34 @@
 		uart at 80007000 {
 			status = "okay";
 		};
+
+		i2c at 80004000 {
+			tc3589x at 42 {
+				compatible = "tc3589x";
+				reg = <0x42>;
+			};
+
+			tps61052 at 33 {
+				compatible = "tps61052";
+				reg = <0x33>;
+			};
+		};
+
+		i2c at 80128000 {
+			lp5521 at 0x33 {
+				compatible = "lp5521";
+				reg = <0x33>;
+			};
+
+			lp5521 at 0x34 {
+				compatible = "lp5521";
+				reg = <0x34>;
+			};
+
+			bh1780 at 0x29 {
+				compatible = "rohm,bh1780gli";
+				reg = <0x33>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
