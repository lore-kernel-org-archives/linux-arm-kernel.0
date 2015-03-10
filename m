From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:40 +0900
Subject: [PATCH 03/15] ARM: shmobile: r8a7790: tidyup SDHI register size on
 DTSI
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <66f47ed0e86d823b57ff9ab39ab18640fa053155.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7790 SDHI ch0/ch1 has SD_DMACR which is located in 0x324.
This patch updates register size

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 5ce3564..31569ac 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -493,7 +493,7 @@
 
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee100000 0 0x200>;
+		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
@@ -503,7 +503,7 @@
 
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee120000 0 0x200>;
+		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
-- 
2.1.4
