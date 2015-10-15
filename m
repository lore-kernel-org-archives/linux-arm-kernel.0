From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:23:58 +0900
Subject: [PATCH v11 3/8] arm64: renesas: r8a7795 dtsi: Add dummy
 dma-controller nodes
In-Reply-To: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444890243-6978-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add dummy nodes for the 3 DMA controllers.
This allows to start describing DMA channels for DMA slaves now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Changes since v10:
- None

Changes from V9: (Magnus Damm <damm+renesas@opensource.se>)
- Updated to remove fuzz

Changes from V8: (Magnus Damm <damm+renesas@opensource.se>)
- Updated to remove fuzz

Changes from V7: (Magnus Damm <damm+renesas@opensource.se>)
- Changed order not to depend on SCIF patch(es)

Based on:
 [PATCH 2/6] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 77f93a77aa79..3d97a089e8be 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -254,5 +254,17 @@
 				#power-domain-cells = <0>;
 			};
 		};
+
+		dmac0: dma-controller at e6700000 {
+			/* Empty node for now */
+		};
+
+		dmac1: dma-controller at e7300000 {
+			/* Empty node for now */
+		};
+
+		dmac2: dma-controller at e7310000 {
+			/* Empty node for now */
+		};
 	};
 };
-- 
2.1.4
