From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:12:50 +0000
Subject: [PATCH 1/2] arm64: dts: fix the i2c aliasing to match to schematics.
In-Reply-To: <1449857504-11365-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449857504-11365-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449857570-11488-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the i2c bus number aliasing so that it matches with the
schematics bus naming.

Without this patch the user might would get bus numbers depending on
the order the devices are probed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 6b8abbe..6f19956 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -20,6 +20,9 @@
 	aliases {
 		serial0 = &blsp1_uart2;
 		serial1 = &blsp1_uart1;
+		i2c0	= &blsp_i2c2;
+		i2c1	= &blsp_i2c6;
+		i2c3	= &blsp_i2c4;
 	};
 
 	chosen {
-- 
1.9.1
