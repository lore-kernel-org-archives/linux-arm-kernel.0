From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:56:09 +0000
Subject: [PATCH 10/12] ARM: dts: apq8064: Remove incorrect gsbi2 node.
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678169-13350-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8c3166f5d74b7936d29dc44f778e759c1b9fb43a (ARM: DT: apq8064: Add i2c device nodes)
added a new gsbi2 node which is totally wrong for 2 reasons.
First the address range is not something which maps to gsbi2 according
to datasheet and 3.4 sources.
Secondly 8064 devices do not use gsbi2 for i2c according to 3.4 kernel sources.
Removing this node as this node would never get tested.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 63edafc..ba44f30 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -201,26 +201,6 @@
 			};
 		};
 
-		gsbi2: gsbi at 12480000 {
-			status = "disabled";
-			compatible = "qcom,gsbi-v1.0.0";
-			reg = <0x12480000 0x100>;
-			clocks = <&gcc GSBI2_H_CLK>;
-			clock-names = "iface";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			i2c2: i2c at 124a0000 {
-				compatible = "qcom,i2c-qup-v1.1.1";
-				reg = <0x124a0000 0x1000>;
-				interrupts = <0 196 IRQ_TYPE_NONE>;
-				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
-				clock-names = "core", "iface";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-		};
 
 		gsbi7: gsbi at 16600000 {
 			status = "disabled";
-- 
1.9.1
