From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 23:42:51 +0200
Subject: [PATCH 2/5 v2] dma: pl08x: Add Faraday FTDMAC020 to compatible list
In-Reply-To: <20170520214254.21541-1-linus.walleij@linaro.org>
References: <20170520214254.21541-1-linus.walleij@linaro.org>
Message-ID: <20170520214254.21541-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the PL08x bindings to include the Faraday Technology
FTDMAC020 DMA engine, as it is clearly a derivative of the PL08x
PrimeCell. Also specify that it needs the special peripheral ID
specified to work properly.

Cc: devicetree at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add in the ACK from Rob.
---
 Documentation/devicetree/bindings/dma/arm-pl08x.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.txt b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
index 8a0097a029d3..0ba81f79266f 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
@@ -3,6 +3,11 @@
 Required properties:
 - compatible: "arm,pl080", "arm,primecell";
 	      "arm,pl081", "arm,primecell";
+	      "faraday,ftdmac020", "arm,primecell"
+- arm,primecell-periphid: on the FTDMAC020 the primecell ID is not hard-coded
+  in the hardware and must be specified here as <0x0003b080>. This number
+  follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
+  for Faraday Technology.
 - reg: Address range of the PL08x registers
 - interrupt: The PL08x interrupt number
 - clocks: The clock running the IP core clock
@@ -20,8 +25,8 @@ Optional properties:
 - dma-requests: contains the total number of DMA requests supported by the DMAC
 - memcpy-burst-size: the size of the bursts for memcpy: 1, 4, 8, 16, 32
   64, 128 or 256 bytes are legal values
-- memcpy-bus-width: the bus width used for memcpy: 8, 16 or 32 are legal
-  values
+- memcpy-bus-width: the bus width used for memcpy in bits: 8, 16 or 32 are legal
+  values, the Faraday FTDMAC020 can also accept 64 bits
 
 Clients
 Required properties:
-- 
2.9.4
