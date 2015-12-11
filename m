From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:29:58 +0000
Subject: [PATCH 1/4] ARM: dts: qcom: apq8064-ifc6410 Use hardware flow control
 for GSBI6
In-Reply-To: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449858598-13429-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

GSBI6 UART module is connected to BT chip, which uses
hardware flow control lines. Enable them on SoC side.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 11ac608..80c6695 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -164,7 +164,7 @@
 
 		gsbi at 16500000 {
 			status = "ok";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
 
 			serial at 16540000 {
 				status = "ok";
-- 
1.9.1
