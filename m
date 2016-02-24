From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Feb 2016 15:52:46 +0100
Subject: [PATCH] ARM: dts: imx6q: add missing links between ipu2 and mipi dsi
Message-ID: <1456325566-20375-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backlinks are already there since commit 4520e69238b3 ("ARM: dts:
imx6qdl: Add IPU DI ports and endpoints, move imx-drm node to dtsi")
and were moved by commit 70c2652c6c5b ("ARM: dts: imx6qdl: Move existing
MIPI DSI ports into a new 'ports' node"), but the links from IPU2 DI0/1
to the MIPI DSI mux are missing. Fix this.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0d93c0e..26418f9 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -162,6 +162,7 @@
 				};
 
 				ipu2_di0_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_2>;
 				};
 
 				ipu2_di0_lvds0: endpoint at 3 {
@@ -183,6 +184,7 @@
 				};
 
 				ipu2_di1_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_3>;
 				};
 
 				ipu2_di1_lvds0: endpoint at 3 {
-- 
2.7.0
