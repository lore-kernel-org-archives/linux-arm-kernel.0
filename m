From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 26 Jun 2014 15:15:02 +0530
Subject: [PATCH v2] ARM: dts: add hdmi regulators for exynos5800 based peach-pi
 board
Message-ID: <1403775902-14227-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding regulators for HDMI for Peach-pi board.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
v2: 1) Add blank line before hdmi regulators.

Based on Kukjin's for-next branch.
Depends on:
1) PMIC addition to Peach-pi: http://www.spinics.net/lists/linux-samsung-soc/msg33166.html
2) tps65090 addition to Peach-pi: http://www.spinics.net/lists/linux-samsung-soc/msg32464.html

 arch/arm/boot/dts/exynos5800-peach-pi.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 2c2c137..b5a2a99 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -127,6 +127,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	ddc = <&i2c_2>;
+
+	hdmi-en-supply = <&tps65090_fet7>;
+	vdd-supply = <&ldo8_reg>;
+	vdd_osc-supply = <&ldo10_reg>;
+	vdd_pll-supply = <&ldo8_reg>;
 };
 
 &hsi2c_7 {
-- 
1.7.9.5
