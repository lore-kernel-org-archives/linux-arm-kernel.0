From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Tue, 18 Aug 2015 22:21:52 +0200
Subject: [PATCH v3 1/2] dt: snps,
 dw-apb-ssi: Document new I/O data register width property
In-Reply-To: <1439929313-4948-1-git-send-email-michael@smart-africa.com>
References: <1439929313-4948-1-git-send-email-michael@smart-africa.com>
Message-ID: <1439929313-4948-2-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change documents a new property for the snps,dw-apb-ssi device,
allowing an implementer to specify either four byte or two bytes
access to the SPI controller data register.

This supports a change that unbreaks this driver on picoXcell
platforms.

Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
---
Changes in v3:
  - Rename the DT property as requested by Rob Herring.

Changes in v2:
  - Incorporate review feedback from Andy Shevchenko, reworking the
    bindings to reflect common practice.

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bd99193..204b311 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - cs-gpios : Specifies the gpio pis to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
+- reg-io-width : The I/O register width (in bytes) implemented by this
+  device.  Supported values are 2 or 4 (the default).
 
 Child nodes as per the generic SPI binding.
 
-- 
2.1.4
