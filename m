From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 22 Aug 2014 11:13:02 +0200
Subject: [PATCH] ARM: dts: nitrogen6x: Add Intersil ISL1208 RTC
Message-ID: <1408698782-2327-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the battery backed real time clock connected to I2C1
to the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 2c67048..0821812 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -192,6 +192,11 @@
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
+
+	rtc: rtc at 6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
 };
 
 &i2c2 {
-- 
2.1.0.rc1
