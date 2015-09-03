From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu,  3 Sep 2015 18:59:53 +0100
Subject: [PATCH v5 5/6] [media] c8sectpfe: Update DT binding doc with some
 minor fixes
In-Reply-To: <1441303194-28211-1-git-send-email-peter.griffin@linaro.org>
References: <1441303194-28211-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441303194-28211-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/media/stih407-c8sectpfe.txt        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
index e70d840..cc51b1f 100644
--- a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
+++ b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
@@ -55,20 +55,20 @@ Example:
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
 		pinctrl-0	= <&pinctrl_tsin0_serial>;
 		pinctrl-1	= <&pinctrl_tsin0_parallel>;
 		pinctrl-2	= <&pinctrl_tsin3_serial>;
 		pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
 		pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
-
+		pinctrl-names	= "tsin0-serial",
+				  "tsin0-parallel",
+				  "tsin3-serial",
+				  "tsin4-serial",
+				  "tsin5-serial";
 		clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
-		clock-names = "stfe";
+		clock-names = "c8sectpfe";
 
 		/* tsin0 is TSA on NIMA */
 		tsin0: port at 0 {
-- 
1.9.1
