From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Jun 2013 10:47:17 +0100
Subject: [PATCH] ARM: kernel: document ARM CPUs clock-frequency property
Message-ID: <1371635237-22860-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM CPU device tree nodes may contain an optional clock-frequency
property, when set, this property must contain the CPU frequency in Hz,
which is then used by the topology parsing code in
arch/arm/kernel/topology.c to infer the CPU capacity.

Document this property to avoid any possible confusion on the
clock-frequency unit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..a33b956 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -45,6 +45,8 @@ For the ARM architecture every CPU node must contain the following properties:
 		"marvell,xsc3"
 		"marvell,xscale"
 
+- clock-frequency : The frequency of the CPU, in Hz. Optional.
+
 Example:
 
 	cpus {
-- 
1.8.1.2
