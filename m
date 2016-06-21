From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Jun 2016 18:22:45 +0100
Subject: [PATCH v2 4/8] arm64: dts: db820c: add support to LS-I2C1
In-Reply-To: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466529769-2674-5-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to LS_I2C1 on LS expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 0d78c4e..3114710 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,6 +18,7 @@
 		serial0 = &blsp2_uart1;
 		serial1 = &blsp2_uart2;
 		i2c0	= &blsp1_i2c2;
+		i2c1	= &blsp2_i2c1;
 	};
 
 	chosen {
@@ -47,5 +48,10 @@
 			status = "okay";
 		};
 
+		i2c at 075b6000 {
+		/* On Low speed expansion */
+			label = "LS-I2C1";
+			status = "okay";
+		};
 	};
 };
-- 
2.7.4
