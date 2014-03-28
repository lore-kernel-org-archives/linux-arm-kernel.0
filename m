From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Mar 2014 14:21:07 +0000
Subject: [PATCH] ARM: topology: Make it clear that all CPUs need to be
 described
Message-ID: <1396016467-23257-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The ARMv8 code will reject topologies that omit some CPUs (and it's not
clear that it's ever sensible to do so). Update the binding document to
make this clear.

Since we're reformatting the text also fix incorrect grammar in the
final "Any other configuration..." section by removing "consider".

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/arm/topology.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index 4aa20e7..1061faf 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -75,9 +75,10 @@ The cpu-map node can only contain three types of child nodes:
 
 whose bindings are described in paragraph 3.
 
-The nodes describing the CPU topology (cluster/core/thread) can only be
-defined within the cpu-map node.
-Any other configuration is consider invalid and therefore must be ignored.
+The nodes describing the CPU topology (cluster/core/thread) can only
+be defined within the cpu-map node and every core/thread in the system
+must be defined within the topology.  Any other configuration is
+invalid and therefore must be ignored.
 
 ===========================================
 2.1 - cpu-map child nodes naming convention
-- 
1.9.1
