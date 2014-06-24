From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 24 Jun 2014 11:19:42 +0100
Subject: [PATCH v3 4/8] dt-bindings: ata: add ahci_imx electrical properties
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Message-ID: <E1WzNpG-0005ds-P3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for the electrical properties for the iMX SATA
controller.  There are many values for these, and listing them would
be error prone.  Refer readers to the device documentation and driver
source code for these details.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/devicetree/bindings/ata/imx-sata.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.txt b/Documentation/devicetree/bindings/ata/imx-sata.txt
index aeb99dd986b0..a13f0f603776 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.txt
+++ b/Documentation/devicetree/bindings/ata/imx-sata.txt
@@ -13,6 +13,14 @@ with some special extensions at integration level.
   required entry in clock-names
 - clock-names : should include "sata", "sata_ref" and "ahb" entries
 
+Optional properties:
+- fsl,transmit-level-mV : transmit voltage level, in millivolts.
+- fsl,transmit-boost-mdB : transmit boost level, in milli-decibels
+- fsl,transmit-atten-16ths : transmit attenuation, in 16ths
+- fsl,receive-eq-mdB : receive equalisation, in milli-decibels
+  Please refer to the technical documentation or the driver source code
+  for the list of legal values for these options.
+
 Examples:
 
 sata at 02200000 {
-- 
1.8.3.1
