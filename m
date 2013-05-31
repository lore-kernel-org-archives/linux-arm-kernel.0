From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:49 +0200
Subject: [PATCH 14/39] ARM: u300: enable MMC/SD card from device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-15-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for the U300 MMC/SD card slot from the device
tree boot. No other changes needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index d1ab4e9..ae51dd1 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -193,5 +193,19 @@
 			interrupt-parent = <&vicb>;
 			interrupts = <20>;
 		};
+
+		mmcsd: mmcsd at c0001000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0xc0001000 0x1000>;
+			interrupt-parent = <&vicb>;
+			interrupts = <6 7>;
+			max-frequency = <24000000>;
+			bus-width = <4>; // SD-card slot
+			mmc-cap-mmc-highspeed;
+			mmc-cap-sd-highspeed;
+			cd-gpios = <&gpio 12 0x4>;
+			cd-inverted;
+			vmmc-supply = <&ab3100_ldo_g_reg>;
+		};
 	};
 };
-- 
1.7.11.3
