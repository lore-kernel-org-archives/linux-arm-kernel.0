From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Jun 2013 15:39:06 +0100
Subject: [PATCH 3/3] ARM: kernel: document ARM CPUs clocks and
 clock-frequency properties
In-Reply-To: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
References: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1371739146-32639-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM CPU device tree nodes may contain a "clock-frequency" property,
when set, this property must contain the CPU frequency in Hz,
which is then used by the topology parsing code in
arch/arm/kernel/topology.c to deduced the CPU capacity. The "clocks"
property, if present shall be a phandle to a valid clock node.

Document thes properties to avoid any possible confusion on the
clock-frequency unit and also specify that "device_type" is also
used by the topology code.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f32494d..1ce1ace 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -10,7 +10,7 @@ http://devicetree.org
 
 For the ARM architecture every CPU node must contain the following properties:
 
-- device_type:	must be "cpu"
+- device_type:	must be "cpu". Use by the topology code.
 - reg:		property matching the CPU MPIDR[23:0] register bits
 		reg[31:24] bits must be set to 0
 - compatible:	should be one of:
@@ -45,6 +45,11 @@ For the ARM architecture every CPU node must contain the following properties:
 		"marvell,xsc3"
 		"marvell,xscale"
 
+- clocks:	phandle and clock specifier for the CPU clock, used if
+		"device_type" is present.
+- clock-frequency: the frequency of the CPU, in Hz. Mandatory if "device_type"
+		   is also present, used as fallback is "clocks" is not present.
+
 Example:
 
 	cpus {
-- 
1.8.1.2
