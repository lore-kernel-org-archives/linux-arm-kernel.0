From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 11 Sep 2018 09:26:55 +0200
Subject: [PATCH v1 2/7] dt-bindings: stm32-dmamux: Add one cell to support
 DMA/MDMA chain
In-Reply-To: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1536650820-16076-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add one cell to support DMA/MDMA chaining.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/dma/stm32-dmamux.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
index 1b893b2..8e092d2 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
@@ -4,9 +4,6 @@ Required properties:
 - compatible:	"st,stm32h7-dmamux"
 - reg:		Memory map for accessing module
 - #dma-cells:	Should be set to <3>.
-		First parameter is request line number.
-		Second is DMA channel configuration
-		Third is Fifo threshold
 		For more details about the three cells, please see
 		stm32-dma.txt documentation binding file
 - dma-masters:	Phandle pointing to the DMA controllers.
@@ -53,7 +50,7 @@ dma2: dma at 40020400 {
 		     <68>,
 		     <69>,
 		     <70>;
-	clocks = <&timer_clk>;
+	clocks = <&clk_hclk>;
 	#dma-cells = <4>;
 	st,mem2mem;
 	resets = <&rcc 150>;
-- 
2.7.4
