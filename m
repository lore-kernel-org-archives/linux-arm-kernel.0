From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 23 Jun 2017 15:00:51 +0200
Subject: [PATCH v2 3/5] dt-bindings: stm32-dma: Add property to handle STM32
 DMAMUX
In-Reply-To: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
References: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1498222853-11110-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an optional property needed for STM32 DMA controller
addressed via STM32 DMAMUX.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v2:
        * Typo fix
---
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 4408af6..340c918 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -16,6 +16,9 @@ Optional properties:
 - resets: Reference to a reset controller asserting the DMA controller
 - st,mem2mem: boolean; if defined, it indicates that the controller supports
   memory-to-memory transfer
+- st,dmamux: boolean; if defined, it indicates that the controller is behind a
+  DMA multiplexer. In that case, using dma instances doesn't work for DMA
+  clients. They have to use dma-router instances.
 
 Example:
 
@@ -39,7 +42,7 @@ Example:
 * DMA client
 
 DMA clients connected to the STM32 DMA controller must use the format
-described in the dma.txt file, using a five-cell specifier for each
+described in the dma.txt file, using a four-cell specifier for each
 channel: a phandle to the DMA controller plus the following four integer cells:
 
 1. The channel id
-- 
1.9.1
