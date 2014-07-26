From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jul 2014 19:20:38 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string from
 Documentation
In-Reply-To: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
Message-ID: <1406395238-29758-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string "marvell,mv78230-a0-i2c" should only be used
internally when at run time we detect an Armada XP with broken
hardware offload. This string should never appear in DT blobs passed
to the kernel. Hence remove it from the binding Documentation.

Patch proposed by Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 5c30026921ae..6eb6f6e40ba1 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -9,11 +9,6 @@ Required properties :
                      - "allwinner,sun6i-a31-i2c"
                      - "marvell,mv64xxx-i2c"
                      - "marvell,mv78230-i2c"
-                     - "marvell,mv78230-a0-i2c"
-                       * Note: Only use "marvell,mv78230-a0-i2c" for a
-                         very rare, initial version of the SoC which
-                         had broken offload support.  Linux
-                         auto-detects this and sets it appropriately.
  - interrupts      : The interrupt number
 
 Optional properties :
-- 
2.0.1
