From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 25 May 2016 11:29:42 -0500
Subject: [PATCH 4/5] ARM: dts: Arria10 ECC Manager IRQ controller changes
In-Reply-To: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1464193783-5071-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Changes to support IRQ controller implementation including adding
new property irq-controller to eccmgr and adding IRQ property
to children.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 27cc497..0901090 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -606,16 +606,22 @@
 			#size-cells = <1>;
 			interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
 				     <0 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			ranges;
 
 			l2-ecc at ffd06010 {
 				compatible = "altr,socfpga-a10-l2-ecc";
 				reg = <0xffd06010 0x4>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+					     <32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			ocram-ecc at ff8c3000 {
 				compatible = "altr,socfpga-a10-ocram-ecc";
 				reg = <0xff8c3000 0x400>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>,
+					     <33 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
1.7.9.5
