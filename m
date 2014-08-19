From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 Aug 2014 17:08:29 +0200
Subject: [PATCH 2/6] ARM: dts: add hdmi regulators for exynos5800 based
 peach-pi board
In-Reply-To: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1408460913-13863-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

Adding regulators for HDMI for Peach-pi board.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

v2: 1) Add blank line before hdmi regulators.

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index f753eae..e613827 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -140,6 +140,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	ddc = <&i2c_2>;
+
+	hdmi-en-supply = <&tps65090_fet7>;
+	vdd-supply = <&ldo8_reg>;
+	vdd_osc-supply = <&ldo10_reg>;
+	vdd_pll-supply = <&ldo8_reg>;
 };
 
 &hsi2c_4 {
-- 
2.0.1
