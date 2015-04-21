From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 21 Apr 2015 15:59:53 +0200
Subject: [PATCH] ARM: dts: imx6: phyFLEX: USB VBUS control is active-high
Message-ID: <1429624793-16223-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed-regulator bindings require a separate property enable-active-high,
the standard gpio phandle property polarity setting is ignored.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 19cc269..1ce6133 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -31,6 +31,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio4 15 0>;
+			enable-active-high;
 		};
 
 		reg_usb_h1_vbus: regulator at 1 {
@@ -40,6 +41,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 0 0>;
+			enable-active-high;
 		};
 	};
 
-- 
2.1.4
