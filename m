From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:44 +0100
Subject: [PATCH 5/8] arm64: dts: db820c: add support to I2C on HS
In-Reply-To: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466452907-23290-6-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to i2c bus on High speed connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 3114710..aefbb64 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -19,6 +19,7 @@
 		serial1 = &blsp2_uart2;
 		i2c0	= &blsp1_i2c2;
 		i2c1	= &blsp2_i2c1;
+		i2c2	= &blsp2_i2c0;
 	};
 
 	chosen {
@@ -53,5 +54,11 @@
 			label = "LS-I2C1";
 			status = "okay";
 		};
+
+		i2c at 075b5000 {
+		/* On High speed expansion */
+			label = "HS-I2C2";
+			status = "okay";
+		};
 	};
 };
-- 
2.7.4
