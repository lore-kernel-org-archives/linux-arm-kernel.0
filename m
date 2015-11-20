From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:15 -0800
Subject: [PATCH 08/29] ARM: shmobile: r8a7794: Disable all IPMMU nodes by
 default
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <832d3e4c823be3c09e20b33793ac668c77ea5bd6.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a7794 IPMMU nodes for MX and DS are currently lacking
a line containing 'status = "disabled"', fix this by
making sure they are disabled like all other IPMMU nodes.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6fc1acff507f..018ff56470b6 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1097,6 +1097,7 @@
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
+		status = "disabled";
 	};
 
 	ipmmu_mp: mmu at ec680000 {
@@ -1113,6 +1114,7 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
+		status = "disabled";
 	};
 
 	ipmmu_gp: mmu at e62a0000 {
-- 
2.1.4
