From: stefan@agner.ch (Stefan Agner)
Date: Wed,  3 Dec 2014 01:12:01 +0100
Subject: [PATCH 02/12] ARM: dts: vf610: add Miscellaneous System Control
 Module (MSCM)
In-Reply-To: <1417565531-4507-1-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
Message-ID: <1417565531-4507-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Miscellaneous System Control Module (MSCM) to the base
device tree for Vybrid SoCs. This module contains the peripheral
interrupt router, which is handling the routing of the interrupts
between the two cores.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 505969a..85fb697 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -55,6 +55,11 @@
 			#size-cells = <1>;
 			ranges;
 
+			mscm: mscm at 40001000 {
+				compatible = "fsl,vf610-mscm";
+				reg = <0x40001000 0x1000>;
+			};
+
 			edma0: dma-controller at 40018000 {
 				#dma-cells = <2>;
 				compatible = "fsl,vf610-edma";
-- 
2.1.3
