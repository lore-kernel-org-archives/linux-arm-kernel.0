From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:16 +0900
Subject: [PATCH 08/10] arm64: dts: r8a7795: Add SATA controller node
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <4c13472b8cc4a326041584b88c534663bb829102.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This adds SATA device node to r8a7795.dtsi.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
[uli: adjusted for new MSTP clock scheme]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e14251164480..9ce6a5ea6629 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -767,5 +767,13 @@
 				};
 			};
 		};
+
+		sata: sata at ee300000 {
+			compatible = "renesas,sata-r8a7795";
+			reg = <0 0xee300000 0 0x1fff>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
