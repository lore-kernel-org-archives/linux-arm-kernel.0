From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 27 Aug 2015 13:29:35 +0100
Subject: [PATCH v2 5/5] [media] c8sectpfe: Update DT binding doc with some
 minor fixes
In-Reply-To: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
References: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1440678575-21646-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/media/stih407-c8sectpfe.txt      | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
index e70d840..5d6438c 100644
--- a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
+++ b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
@@ -55,21 +55,20 @@ Example:
 		status = "okay";
 		reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
 		reg-names = "stfe", "stfe-ram";
-		interrupts = <0 34 0>, <0 35 0>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_NONE>, <GIC_SPI 35 IRQ_TYPE_NONE>;
 		interrupt-names = "stfe-error-irq", "stfe-idle-irq";
-
-		pinctrl-names	= "tsin0-serial", "tsin0-parallel", "tsin3-serial",
-				"tsin4-serial", "tsin5-serial";
-
+		pinctrl-names	= "tsin0-serial",
+				  "tsin0-parallel",
+				  "tsin3-serial",
+				  "tsin4-serial",
+				  "tsin5-serial";
 		pinctrl-0	= <&pinctrl_tsin0_serial>;
 		pinctrl-1	= <&pinctrl_tsin0_parallel>;
 		pinctrl-2	= <&pinctrl_tsin3_serial>;
 		pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
 		pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
-
 		clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
-		clock-names = "stfe";
-
+		clock-names = "c8sectpfe";
 		/* tsin0 is TSA on NIMA */
 		tsin0: port at 0 {
 			tsin-num		= <0>;
@@ -78,7 +77,6 @@ Example:
 			reset-gpios		= <&pio15 4 GPIO_ACTIVE_HIGH>;
 			dvb-card		= <STV0367_TDA18212_NIMA_1>;
 		};
-
 		tsin3: port at 3 {
 			tsin-num		= <3>;
 			serial-not-parallel;
-- 
1.9.1
