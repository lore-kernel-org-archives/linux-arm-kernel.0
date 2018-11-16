From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:46 +0100
Subject: [PATCH v5 09/12] arm64: dts: mt2712e: Use the new mmsys clock
 compatible
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
Message-ID: <20181116125449.23581-10-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

Move the clock part of the mmsys in a child node.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index ee627a7c7b45..dd6837df92c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -412,9 +412,13 @@
 	};
 
 	mmsys: syscon at 14000000 {
-		compatible = "mediatek,mt2712-mmsys", "syscon";
+		compatible = "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
 		reg = <0 0x14000000 0 0x1000>;
-		#clock-cells = <1>;
+
+		mmsys_clk: clock-controller at 14000000 {
+			compatible = "mediatek,mt2712-mmsys-clk";
+			#clock-cells = <1>;
+		};
 	};
 
 	imgsys: syscon at 15000000 {
-- 
2.19.1
