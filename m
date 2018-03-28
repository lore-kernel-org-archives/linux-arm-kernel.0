From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Wed, 28 Mar 2018 11:14:43 +0530
Subject: [PATCH 1/2][v7] dt-bindings: mtd-physmap: Add endianness supports
Message-ID: <20180328054443.2829-1-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Connection between flash and controller is not necessary to be always
of same type. It may varies from platform to platform.

Adding endianness (optional) property to provide connection type
information.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2: updated subject
Changes for v3: fixed typo for "big-endian"
Changes for v4: Moved binding definition in mtd-physmap.txt
as discussed at https://patchwork.ozlabs.org/patch/842543/
Changes for v5: Sending as it is
Changes for v6: Updated binding when endianness property is absent
Changes for v7: Updated binding details

 Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 4a0a48bf4ecb..232fa12e90ef 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -41,6 +41,13 @@ additional (optional) property is defined:
 
  - erase-size : The chip's physical erase block size in bytes.
 
+ The device tree may optionally contain endianness property.
+ little-endian or big-endian : It Represents the endianness that should be used
+                               by the controller to  properly read/write data
+			       from/to the flash. If this property is missing,
+			       the endianness is chosen by the system
+			       (potentially based on extra configuration options).
+
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
 
-- 
2.14.1
