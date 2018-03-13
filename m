From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 17:42:00 +0100
Subject: [PATCH v1 1/8] dt-bindings: stm32-dma: introduce DMA features bitfield
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bitfield intends to address features to be activated within the
driver. Initially the mask was only meant for FIFO Threshold management.
Backward compatibility is preserved but the meaning of this field has been
extended to features instead of only threshold.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 0b55718..c5f5190 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -62,14 +62,14 @@ channel: a phandle to the DMA controller plus the following four integer cells:
 	0x1: medium
 	0x2: high
 	0x3: very high
-4. A 32bit mask specifying the DMA FIFO threshold configuration which are device
-   dependent:
- -bit 0-1: Fifo threshold
+4. A 32bit bitfield value specifying DMA features which are device dependent:
+ -bit 0-1: DMA FIFO threshold selection
 	0x0: 1/4 full FIFO
 	0x1: 1/2 full FIFO
 	0x2: 3/4 full FIFO
 	0x3: full FIFO
 
+
 Example:
 
 	usart1: serial at 40011000 {
-- 
2.7.4
