From: kalyan.kinthada@alliedtelesis.co.nz (Kalyan Kinthada)
Date: Thu, 28 Sep 2017 17:04:07 +1300
Subject: [PATCH 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
In-Reply-To: <20170928040407.8933-1-kalyan.kinthada@alliedtelesis.co.nz>
References: <20170928040407.8933-1-kalyan.kinthada@alliedtelesis.co.nz>
Message-ID: <20170928040407.8933-3-kalyan.kinthada@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit modifies the documentation for
"marvell,mv78230-a0-i2c" compatible string.

The "marvell,mv78230-a0-i2c" compatible string enables the workaround
for an i2c repeated start timing violation, but unlike
"marvell,mv78230-i2c" it disables the i2c offload support. This is
applicable to a number of SoCs such as early revisions of the Armada XP
and the Armada 38x.

Deleted the special note for "marvell,mv78230-a0-i2c" as it can
be used by other SoCs as well.

Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 5c30026921ae..37c00ad1c0bb 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -10,10 +10,6 @@ Required properties :
                      - "marvell,mv64xxx-i2c"
                      - "marvell,mv78230-i2c"
                      - "marvell,mv78230-a0-i2c"
-                       * Note: Only use "marvell,mv78230-a0-i2c" for a
-                         very rare, initial version of the SoC which
-                         had broken offload support.  Linux
-                         auto-detects this and sets it appropriately.
  - interrupts      : The interrupt number
 
 Optional properties :
-- 
2.14.1
