From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 05 May 2015 09:37:35 +0530
Subject: [RESEND-PATCH] ARM: dts: Add missing irq pinctrl for max77686 on
 smdk5250
Message-ID: <1430798855-27271-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yadwinder Singh Brar <yadi.brar@samsung.com>

This patch adds pinctrl configuration for using configuring gpx3-2 as an
external interrupt from max77686. Though max77686 RTC is enabled and gets
probed by default, it doesnt work as its unable to get interrupt.

This patch makes max77686 RTC work and also configures it as wakeup source.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---

Initial version of this patch was part of following series, though
they are not dependent on each other, resubmitting after rebasing
and detaching second one from first patch in the series [1]

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303652.html

 arch/arm/boot/dts/exynos5250-smdk5250.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bc27cc2..4fe186d 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -131,6 +131,9 @@
 		reg = <0x09>;
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max77686_irq>;
+		wakeup-source;
 
 		voltage-regulators {
 			ldo1_reg: LDO1 {
@@ -410,3 +413,12 @@
 		};
 	};
 };
+
+&pinctrl_0 {
+	max77686_irq: max77686-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
-- 
2.2.0
