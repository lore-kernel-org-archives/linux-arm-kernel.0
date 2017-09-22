From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 22 Sep 2017 09:31:31 +0200
Subject: [RESEND PATCH v5 3/4] dt-bindings: stm32-dma: add a property to
 handle STM32 DMAMUX
In-Reply-To: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
References: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1506065492-31478-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 DMA controller has to exposed its number of request line to be
addressed via STM32 DMAMUX.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Version history:
    v5:
    v4:
        * get rid of st,dmamux property
        * number of DMA requests is exposed for DMAMUX
    v3:
        * None
    v2:
        * Typo fix
---
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 4408af6..77542e1 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -13,6 +13,7 @@ Required properties:
 - #dma-cells : Must be <4>. See DMA client paragraph for more details.
 
 Optional properties:
+- dma-requests : Number of DMA requests supported.
 - resets: Reference to a reset controller asserting the DMA controller
 - st,mem2mem: boolean; if defined, it indicates that the controller supports
   memory-to-memory transfer
@@ -34,12 +35,13 @@ Example:
 		#dma-cells = <4>;
 		st,mem2mem;
 		resets = <&rcc 150>;
+		dma-requests = <8>;
 	};
 
 * DMA client
 
 DMA clients connected to the STM32 DMA controller must use the format
-described in the dma.txt file, using a five-cell specifier for each
+described in the dma.txt file, using a four-cell specifier for each
 channel: a phandle to the DMA controller plus the following four integer cells:
 
 1. The channel id
-- 
2.7.4
