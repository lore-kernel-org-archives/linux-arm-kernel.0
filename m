From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:50:45 +0000
Subject: [PATCH v3 7/8] arm64: dts: qcom: apq8016-sbc: enable bam dma node.
In-Reply-To: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456246245-18383-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables bam dma node, dma is used for both tx and rx on spi
and on high speed serial.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 27288ee..3f15b19 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -33,6 +33,10 @@
 	};
 
 	soc {
+		dma at 7884000 {
+			status = "okay";
+		};
+
 		serial at 78af000 {
 			label = "LS-UART0";
 			status = "okay";
-- 
1.9.1
