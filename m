From: niklas.cassel@axis.com (Niklas Cassel)
Date: Tue, 20 Feb 2018 18:00:42 +0100
Subject: [PATCH 1/8] ARM: dts: artpec: disable Accelerator Coherency Port
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
Message-ID: <20180220170049.22809-2-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accesses via 0x80000000 go through the ACP instead of using the DDR
directly.

Unfortunately the ACP has proven to be the cause of complete system
hangs. Disabling the ACP makes these problems go away.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 2ed11773048d..d9776a97d8ff 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -185,8 +185,7 @@
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		ranges;
-		dma-ranges = <0x80000000 0x00000000 0x40000000>;
-		dma-coherent;
+		dma-ranges;
 
 		ethernet: ethernet at f8010000 {
 			clock-names = "phy_ref_clk", "apb_pclk";
-- 
2.14.2
