From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 18 Jun 2014 19:14:59 +0530
Subject: [PATCH] ARM: dts: add hdmi regulators for exynos5420 based peach-pit
 board
Message-ID: <1403099099-6599-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding regulators for hdmi for peach-pit board.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
Based on for-next branch in Kukjin's tree.
Dependent on:
1) PMIC DT patch at http://www.gossamer-threads.com/lists/linux/kernel/1945703
2) tps65090 DT patch at https://lkml.org/lkml/2014/6/13/483

 arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 1c5b8f9..0a6a1cb 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -229,6 +229,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
 	ddc = <&i2c_2>;
+
+	hdmi-en-supply = <&tps65090_fet7>;
+	vdd-supply = <&ldo8_reg>;
+	vdd_osc-supply = <&ldo10_reg>;
+	vdd_pll-supply = <&ldo8_reg>;
 };
 
 &usbdrd_phy0 {
-- 
1.7.9.5
