From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:47 -0500
Subject: [PATCH 09/10] ARM: dts: Add Arria10 DMA EDAC devicetree entry
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1468512408-5156-10-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera DMA
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 228f663..a506ec0 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -644,6 +644,14 @@
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
 					     <37 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			dma-ecc at ff8c8000 {
+				compatible = "altr,socfpga-dma-ecc";
+				reg = <0xff8c8000 0x400>;
+				altr,ecc-parent = <&pdma>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
+					     <42 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		rst: rstmgr at ffd05000 {
-- 
1.7.9.5
