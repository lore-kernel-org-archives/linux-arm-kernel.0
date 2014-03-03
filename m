From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon,  3 Mar 2014 11:05:55 +0100
Subject: [PATCH v5 2/9] dt: bindings: at91: Add a new binding for the bus
 matrix
In-Reply-To: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
References: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1393841162-25339-3-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This binding is used to initialize the bus matrix base address.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 16f60b4..bf9cb13 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -105,3 +105,17 @@ Example:
 		compatible = "atmel,at91sam9260-rstc";
 		reg = <0xfffffd00 0x10>;
 	};
+
+Bus Matrix controller
+
+required properties:
+- compatible: Should be "atmel,<chip>-bus-matrix".
+  <chip> can be "at91sam9260".
+- reg: Should contain registers location and length
+
+Example:
+
+	matrix: matrix at ffffee00 {
+		compatible = "atmel,at91sam9260-bus-matrix";
+		reg = <0xffffee00 0x200>;
+	};
-- 
1.9.0
