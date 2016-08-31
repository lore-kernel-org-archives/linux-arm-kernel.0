From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed, 31 Aug 2016 15:54:06 +0200
Subject: [PATCH 7/7] dts: sun8i-h3: add I2C0-1 to Orange Pi PC
In-Reply-To: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
References: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1472651646-15579-8-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This board has I2C0-I2C1 exposed on its expansion header.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 602b012..6102e37 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -108,6 +108,16 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.7.4
