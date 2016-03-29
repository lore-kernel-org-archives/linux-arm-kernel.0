From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:44 +0200
Subject: [PATCH 5/7] ARM: dts: lpc4357-ea4357: add adc0
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable adc0 on EA4357 dev kit. This kit has a 22k
potentiometer (R94) connected on ADC0 channel 3.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 079d3cf..bbc70b9 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -38,6 +38,13 @@
 		reg = <0x28000000 0x2000000>; /* 32 MB */
 	};
 
+	vcc: vcc_fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	/* vmmc is controlled by sdmmc host internally */
 	vmmc: vmmc_fixed {
 		compatible = "regulator-fixed";
@@ -461,6 +468,11 @@
 	};
 };
 
+&adc0 {
+	status = "okay";
+	vref-supply = <&vcc>;
+};
+
 &i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.7.4
