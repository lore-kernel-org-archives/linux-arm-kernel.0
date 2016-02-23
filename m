From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:39 +0000
Subject: [PATCH 06/12] ARM: dts: ifc6410: enable spi device on expansion
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236879-2698-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables spi device on the 30 pin expansion connector.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 0073294..8de774c 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -178,6 +178,16 @@
 			};
 		};
 
+		gsbi at 1a200000 {
+			qcom,mode = <GSBI_PROT_SPI>;
+			status = "okay";
+			spi4: spi at 1a280000 {
+				status = "okay";
+				num-cs = <1>;
+				cs-gpios = <&tlmm_pinmux 53 0>;
+			};
+		};
+
 		gsbi at 16500000 {
 			status = "ok";
 			qcom,mode = <GSBI_PROT_UART_W_FC>;
-- 
1.9.1
