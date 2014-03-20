From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Mar 2014 12:59:34 +0000
Subject: [PATCH] ARM: topology: Make it clear that all CPUs need to be
 described
Message-ID: <1395320374-29576-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The ARMv8 code will reject topologies that omit some CPUs (and it's not
clear that it's ever sensible to do so). Update the binding document to
make this clear.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/arm/topology.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index 4aa20e7a424e..1bd5edc225c1 100644
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
+consider invalid and therefore must be ignored.
 
 ===========================================
 2.1 - cpu-map child nodes naming convention
-- 
1.9.1
