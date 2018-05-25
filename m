From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 25 May 2018 11:41:22 +0530
Subject: [PATCH v8 12/12] ARM: dts: ipq8074: Enable few peripherals for hk01
 board
In-Reply-To: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
References: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1527228682-12285-13-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 72c5b4a3..c13ddee 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -21,6 +21,7 @@
 
 	aliases {
 		serial0 = &blsp1_uart5;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
@@ -36,5 +37,58 @@
 		serial at 78b3000 {
 			status = "ok";
 		};
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
+			};
+		};
+
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
+			status = "ok";
+			perst-gpio = <&tlmm 61 0x1>;
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
