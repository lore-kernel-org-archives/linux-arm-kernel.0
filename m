From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:45 +0100
Subject: [PATCH 3/9] dt-bindings: stm32-dma: Fix typo regarding DMA client
 binding
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-4-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only four cells are required for dma client binding not five.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 70cd13f..4408af6 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -40,8 +40,7 @@ Example:
 
 DMA clients connected to the STM32 DMA controller must use the format
 described in the dma.txt file, using a five-cell specifier for each
-channel: a phandle plus four integer cells.
-The four cells in order are:
+channel: a phandle to the DMA controller plus the following four integer cells:
 
 1. The channel id
 2. The request line number
@@ -61,7 +60,7 @@ The four cells in order are:
 	0x1: medium
 	0x2: high
 	0x3: very high
-5. A 32bit mask specifying the DMA FIFO threshold configuration which are device
+4. A 32bit mask specifying the DMA FIFO threshold configuration which are device
    dependent:
  -bit 0-1: Fifo threshold
 	0x0: 1/4 full FIFO
-- 
1.9.1
