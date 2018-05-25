From: christophe.roullier@st.com (Christophe Roullier)
Date: Fri, 25 May 2018 09:46:39 +0200
Subject: [PATCH V0:net-next 2/4] dt-bindings: stm32-dwmac: add support of MPU
 families
In-Reply-To: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
References: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1527234401-15812-3-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for Ethernet MPU families fields

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.txt | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
index 489dbcb..1341012 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
@@ -6,14 +6,28 @@ Please see stmmac.txt for the other unchanged properties.
 The device node has following properties.
 
 Required properties:
-- compatible:  Should be "st,stm32-dwmac" to select glue, and
+- compatible:  For MCU family should be "st,stm32-dwmac" to select glue, and
 	       "snps,dwmac-3.50a" to select IP version.
+	       For MPU family should be "st,stm32mp1-dwmac" to select
+	       glue, and "snps,dwmac-4.20a" to select IP version.
 - clocks: Must contain a phandle for each entry in clock-names.
 - clock-names: Should be "stmmaceth" for the host clock.
 	       Should be "mac-clk-tx" for the MAC TX clock.
 	       Should be "mac-clk-rx" for the MAC RX clock.
+	       For MPU family need to add also "ethstp" for power mode clock and,
+	                                       "syscfg-clk" for SYSCFG clock.
+- interrupt-names: Should contain a list of interrupt names corresponding to
+           the interrupts in the interrupts property, if available.
+		   Should be "macirq" for the main MAC IRQ
+		   Should be "eth_wake_irq" for the IT which wake up system
 - st,syscon : Should be phandle/offset pair. The phandle to the syscon node which
-	      encompases the glue register, and the offset of the control register.
+	       encompases the glue register, and the offset of the control register.
+
+Optional properties:
+- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
+- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock
+	           by RCC
+
 Example:
 
 	ethernet at 40028000 {
-- 
1.9.1
