From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Jun 2016 18:22:47 +0100
Subject: [PATCH v2 6/8] arm64: dts: db820c: add support to LS-SPI0
In-Reply-To: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466529769-2674-7-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to SPI on LS expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index aefbb64..07fe6fb 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -20,6 +20,7 @@
 		i2c0	= &blsp1_i2c2;
 		i2c1	= &blsp2_i2c1;
 		i2c2	= &blsp2_i2c0;
+		spi0	= &blsp1_spi0;
 	};
 
 	chosen {
@@ -55,6 +56,12 @@
 			status = "okay";
 		};
 
+		spi at 07575000 {
+		/* On Low speed expansion */
+			label = "LS-SPI0";
+			status = "okay";
+		};
+
 		i2c at 075b5000 {
 		/* On High speed expansion */
 			label = "HS-I2C2";
-- 
2.7.4
