From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Jun 2014 15:55:50 +0100
Subject: [PATCH] i2c: i2c-st: Rename clock reference to something that exists
Message-ID: <1403708150-32085-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_ICN_REG_0 hasn't existed for a while now.  This was renamed
over a few commits, then finally removed in commit 5aa02b9 (ARM:
STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-st.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt
index 437e0db..4c26fda 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-st.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-st.txt
@@ -31,7 +31,7 @@ i2c0: i2c at fed40000 {
 	compatible	= "st,comms-ssc4-i2c";
 	reg		= <0xfed40000 0x110>;
 	interrupts	=  <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-	clocks		= <&CLK_S_ICN_REG_0>;
+	clocks		= <&clk_s_a0_ls CLK_ICN_REG>;
 	clock-names	= "ssc";
 	clock-frequency = <400000>;
 	pinctrl-names	= "default";
-- 
1.8.3.2
