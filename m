From: christophe.roullier@st.com (Christophe Roullier)
Date: Tue, 24 Apr 2018 17:01:54 +0200
Subject: [PATCH  2/8] dt-bindings: stm32-dwmac: add support of MPU families
In-Reply-To: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1524582120-4451-3-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for Ethernet MPU families fields

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
index 489dbcb..e9d1c4a 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
@@ -6,14 +6,26 @@ Please see stmmac.txt for the other unchanged properties.
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
+	       For MPU family "ethstp" for power mode clock.
+	       For MPU family need also "syscfg-clk" for SYSCFG clock.
+- interrupt-names: Should contain a list of interrupt names corresponding to
+           the interrupts in the interrupts property, if available.
 - st,syscon : Should be phandle/offset pair. The phandle to the syscon node which
-	      encompases the glue register, and the offset of the control register.
+	       encompases the glue register, and the offset of the control register.
+
+Optional properties:
+- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
+- st,int-phyclk :  valid only where PHY do not have quartz and need to be clock
+	           by RCC
+
 Example:
 
 	ethernet at 40028000 {
-- 
1.9.1
