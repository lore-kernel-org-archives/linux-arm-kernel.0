From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 10:02:46 +0800
Subject: [PATCH 4/5] ARM: dts: rockchip: enable saradc for rk3288-evb
In-Reply-To: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1498874567-11219-5-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

saradc in rk3288-evb use 1.8v ref.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index f226ca7..9cee856 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -129,6 +129,15 @@
 		};
 	};
 
+	vccadc_ref: vccadc-ref {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	/* This turns on USB vbus for both host0 (ehci) and host1 (dwc2) */
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
@@ -218,6 +227,11 @@
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vccadc_ref>;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.7.4
