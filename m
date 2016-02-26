From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:35 +0900
Subject: [PATCH 02/14] arm64: dts: r8a7795: pmu: switch to Cortex specific
 device nodes
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <3d0cd46889e0a57ce63dba1f34156b54dfdf0ad2.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@gmail.com>

Instead of using the generic armv8-pmuv3 compatibility use the more
specific Cortex A57 compatibility.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3f00e85641a8..b5e46e4ff72a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -246,8 +246,8 @@
 			power-domains = <&cpg>;
 		};
 
-		pmu {
-			compatible = "arm,armv8-pmuv3";
+		pmu_a57 {
+			compatible = "arm,cortex-a57-pmu";
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.7.0.rc3.207.g0ac5344
