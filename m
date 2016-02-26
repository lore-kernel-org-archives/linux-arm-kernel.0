From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:41 +0900
Subject: [PATCH 08/14] arm64: dts: r8a7795: Add SDHI support to dtsi
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <d9d67010e0c699c838ac84245ec6d8651420d337.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[wsa: squashed some fixes and added mmc-caps]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1072c681f8b4..c2bffd160c18 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -985,5 +985,43 @@
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7795";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a7795";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7795";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			power-domains = <&cpg>;
+			cap-mmc-highspeed;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7795";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			power-domains = <&cpg>;
+			cap-mmc-highspeed;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
