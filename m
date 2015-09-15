From: scottwood@freescale.com (Scott Wood)
Date: Mon, 14 Sep 2015 19:48:27 -0500
Subject: [PATCH] arm64: dts: fsl-ls2085a: Add serial aliases
Message-ID: <20150915004827.GA19862@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These will allow U-Boot to set linux,stdout-path in /chosen based on
the active console device, which will allow devicetree-based earlycon.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
index e281ceb..eae454e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
@@ -55,6 +55,11 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.1.4
