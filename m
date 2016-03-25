From: haas@computerlinguist.org (Michael Haas)
Date: Fri, 25 Mar 2016 20:04:07 +0100
Subject: [PATCH 3/3] sunxi: A20-OLinuXino-LIME2: Add i2c2 bus in DTS
In-Reply-To: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
Message-ID: <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 processor provides a third I2C bus on pins PB20 and PB21.
The A20-OLinuXino-LIME2 exposes this bus via its GPIO1 port.

Olimex also provide a breakout board called the
A20-OLinuXino-LIME2-UEXT. This change is required to properly
support I2C on the UEXT connector found there.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d370166..17791ef 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -179,6 +179,12 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-- 
2.7.2
