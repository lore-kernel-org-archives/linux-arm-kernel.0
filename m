From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 20 Jun 2016 21:01:46 +0100
Subject: [PATCH 7/8] arm64: dts: db820c: add support to SPI on HS
In-Reply-To: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466452907-23290-8-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to SPI on HS expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 07fe6fb..08b063d 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -21,6 +21,7 @@
 		i2c1	= &blsp2_i2c1;
 		i2c2	= &blsp2_i2c0;
 		spi0	= &blsp1_spi0;
+		spi1	= &blsp2_spi5;
 	};
 
 	chosen {
@@ -67,5 +68,11 @@
 			label = "HS-I2C2";
 			status = "okay";
 		};
+
+		spi at 075ba000{
+		/* On High speed expansion */
+			label = "HS-SPI1";
+			status = "okay";
+		};
 	};
 };
-- 
2.7.4
