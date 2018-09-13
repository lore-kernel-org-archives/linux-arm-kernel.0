From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:29:18 +0200
Subject: [PATCH 3/4] ARM: dts: meson8b: odroidc1: enable the SAR ADC
In-Reply-To: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
References: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180913202919.20927-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid-C1 exposes ADC channels 0 and 1 on the GPIO headers. NOTE: Due
to the SoC design these are limited to 1.8V (instead of 3.3V like all
other pins).
Enable the SAR ADC to enable voltage measurements on these pins.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a08dccccdb5e..7c1225658567 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -246,6 +246,11 @@
 	pinctrl-names = "default";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vcc_1v8>;
+};
+
 &sdio {
 	status = "okay";
 
-- 
2.19.0
