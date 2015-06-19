From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Fri, 19 Jun 2015 10:43:54 +0200
Subject: [PATCH 2/2] dt: snps,
 dw-apb-ssi: Describe 16 bit data register usage limitations
In-Reply-To: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
Message-ID: <1434703435-25198-2-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change documents a new property for the snps,dw-apb-ssi device,
allowing an implementer to interact with the SPI controller data
register in 16 bit mode only.  This supports a change that unbreaks
this driver on picoXcell platforms.

Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bd99193..3b2a86f 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -10,6 +10,9 @@ Required properties:
 Optional properties:
 - cs-gpios : Specifies the gpio pis to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
+- snps,data-io-16bit : A boolean property that, when present, causes
+  the driver to interact with the data register using 16 bit I/O instead
+  of the default 32 bit I/O.
 
 Child nodes as per the generic SPI binding.
 
-- 
2.1.4
