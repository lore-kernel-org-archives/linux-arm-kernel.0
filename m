From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 12 Feb 2018 14:08:18 +0100
Subject: [PATCH] ARM: dts: imx6: RDU2: detail USDHC description
Message-ID: <20180212130818.12665-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the slots support 1.8V signaling or SDIO. There is no point in
probing for a SD card on the eMMC controller.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 72f52fcecee1..b5cda226b755 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -602,6 +602,8 @@
 	wp-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
+	no-1-8-v;
+	no-sdio;
 	status = "okay";
 };
 
@@ -613,6 +615,8 @@
 	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
+	no-1-8-v;
+	no-sdio;
 	status = "okay";
 };
 
@@ -622,7 +626,10 @@
 	bus-width = <8>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
+	no-1-8-v;
 	non-removable;
+	no-sdio;
+	no-sd;
 	status = "okay";
 };
 
-- 
2.15.1
