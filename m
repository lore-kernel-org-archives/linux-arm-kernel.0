From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Mon, 12 Mar 2018 13:41:28 +0530
Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness supports
Message-ID: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
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

 Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 4a0a48bf4ecb..691c98f7301d 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -41,6 +41,11 @@ additional (optional) property is defined:
 
  - erase-size : The chip's physical erase block size in bytes.
 
+ The device tree may optionally contain endianness property.
+ little-endian or big-endian : It represents connection between controller and
+			flash. If this property is absent, connection is described
+			by the CFI_DEFAULT_ENDIAN.
+
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
 
-- 
2.14.1
