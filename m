From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Oct 2015 15:01:49 +0900
Subject: [PATCH v12 4/7] arm64: renesas: r8a7795: enable PFC
In-Reply-To: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1445839312-8874-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a PFC node for the on-chip r8a7795 pin controller.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Changes since v10:
- None

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
- None

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- Dropped Kconfig TODO - select PINCTRL happens in patch 1
- Added Acked-by from Laurent

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Added changelog

Based on:
 [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3e5539cceeec..b94e5a9e2c3b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -80,6 +80,11 @@
 			#power-domain-cells = <0>;
 		};
 
+		pfc: pfc at e6060000 {
+			compatible = "renesas,pfc-r8a7795";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			/* Empty node for now */
 		};
-- 
2.1.4
