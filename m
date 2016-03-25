From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 25 Mar 2016 15:36:28 +0000
Subject: [PATCH 4/4] ARM: STi: DT: STiH407: Add DT node for eeprom
In-Reply-To: <1458920188-29612-1-git-send-email-peter.griffin@linaro.org>
References: <1458920188-29612-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1458920188-29612-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 133375b..0d7c6dd 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -58,6 +58,15 @@
 
 		i2c at 9845000 {
 			status = "okay";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom at 50 {
+				compatible = "at,24c256";
+				pagesize = <64>;
+				reg = <0x50>;
+			};
 		};
 
 		i2c at 9540000 {
-- 
1.9.1
