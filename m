From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 May 2018 18:20:04 +0530
Subject: [PATCH V6 12/12] ARM: dts: ipq8074: Enable few peripherals for hk01
 board
In-Reply-To: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
References: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1526475004-10341-13-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 62 ++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 6a838b5..c13ddee 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -21,6 +21,7 @@
 
 	aliases {
 		serial0 = &blsp1_uart5;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
@@ -33,20 +34,61 @@
 	};
 
 	soc {
-		pinctrl at 1000000 {
-			serial_4_pins: serial4_pinmux {
-				mux {
-					pins = "gpio23", "gpio24";
-					function = "blsp4_uart1";
-					bias-disable;
-				};
+		serial at 78b3000 {
+			status = "ok";
+		};
+
+		spi at 78b5000 {
+			status = "ok";
+
+			m25p80 at 0 {
+				  #address-cells = <1>;
+				  #size-cells = <1>;
+				  compatible = "jedec,spi-nor";
+				  reg = <0>;
+				  spi-max-frequency = <50000000>;
 			};
 		};
 
-		serial at 78b3000 {
-			pinctrl-0 = <&serial_4_pins>;
-			pinctrl-names = "default";
+		serial at 78b1000 {
+			 status = "ok";
+		};
+
+		i2c at 78b6000 {
+			 status = "ok";
+		};
+
+		dma at 7984000 {
+			 status = "ok";
+		};
+
+		nand at 79b0000 {
+			status = "ok";
+
+			nand at 0 {
+				reg = <0>;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+				nand-bus-width = <8>;
+			};
+		};
+
+		phy at 86000 {
+			status = "ok";
+		};
+
+		phy at 8e000 {
+			status = "ok";
+		};
+
+		pci at 20000000 {
+			status = "ok";
+			perst-gpio = <&tlmm 58 0x1>;
+		};
+
+		pci at 10000000 {
 			status = "ok";
+			perst-gpio = <&tlmm 61 0x1>;
 		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
