From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 23 Mar 2016 19:48:18 +0000
Subject: [PATCH 12/12] ARM: dts: dragonboard-600c: add spi support
In-Reply-To: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1458762498-9860-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds spi nodes required to provide spi bus support on LS
expansion.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
index 942de04..2201240 100644
--- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
@@ -12,6 +12,7 @@
 		i2c1 = &gsbi3_i2c;
 		i2c2 = &gsbi4_i2c;
 		i2c3 = &gsbi7_i2c;
+		spi0 = &gsbi5_spi;
 	};
 
 	regulators {
@@ -220,6 +221,15 @@
 			};
 		};
 
+		gsbi at 1a200000 {
+			status = "okay";
+			spi at 1a280000 {
+				/* On Low speed expansion */
+				label = "LS-SPI0";
+				status = "okay";
+			};
+		};
+
 		/* DEBUG UART  */
 		gsbi at 16600000 {
 			status = "okay";
-- 
2.5.0
