From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  1 Dec 2017 13:07:08 +0100
Subject: [PATCH 3/3] arm: dts: mt2701: Add reset-cells
In-Reply-To: <20171201120708.30129-1-matthias.bgg@gmail.com>
References: <20171201120708.30129-1-matthias.bgg@gmail.com>
Message-ID: <20171201120708.30129-3-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hifsys and ethsys needs the definition of the reset-cells
property. Fix this.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 965ddfbc9953..05557fce0f1d 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -604,6 +604,7 @@
 		compatible = "mediatek,mt2701-hifsys", "syscon";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb0: usb at 1a1c0000 {
@@ -688,6 +689,7 @@
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet at 1b100000 {
-- 
2.12.3
