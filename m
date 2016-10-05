From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 09:33:32 +0200
Subject: [PATCH v4 6/8] dt-bindings: Add support for Amlogic GXBB SCPI
 Interface
In-Reply-To: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475652814-30619-7-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index faa4b44..04bc171 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -7,7 +7,7 @@ by Linux to initiate various system control and power operations.
 
 Required properties:
 
-- compatible : should be "arm,scpi"
+- compatible : should be "arm,scpi" or "amlogic,meson-gxbb-scpi"
 - mboxes: List of phandle and mailbox channel specifiers
 	  All the channels reserved by remote SCP firmware for use by
 	  SCPI message protocol should be specified in any order
@@ -60,7 +60,8 @@ A small area of SRAM is reserved for SCPI communication between application
 processors and SCP.
 
 Required properties:
-- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
+- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno,
+		or "amlogic,meson-gxbb-sram" for Amlogic GXBB SoC.
 
 The rest of the properties should follow the generic mmio-sram description
 found in ../../sram/sram.txt
@@ -70,7 +71,8 @@ Each sub-node represents the reserved area for SCPI.
 Required sub-node properties:
 - reg : The base offset and size of the reserved area with the SRAM
 - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
-	       shared memory on Juno platforms
+	       shared memory on Juno platforms or
+	       "amlogic,meson-gxbb-scp-shmem" for Amlogic GXBB SoC.
 
 Sensor bindings for the sensors based on SCPI Message Protocol
 --------------------------------------------------------------
-- 
1.9.1
