From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:34:01 +0100
Subject: [PATCH v2 12/13] ARM: dts: db600c: add spi support
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-13-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds spi nodes required to provide spi bus support on LS
expansion.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
index 2f0dfff..34bb415 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -13,6 +13,7 @@
 		i2c1 = &gsbi3_i2c;
 		i2c2 = &gsbi4_i2c;
 		i2c3 = &gsbi7_i2c;
+		spi0 = &gsbi5_spi;
 	};
 
 	regulators {
@@ -181,6 +182,15 @@
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
