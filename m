From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:59:05 +0200
Subject: [PATCH 32/35] arm64: dts: renesas: r8a7795-salvator-x: Enable HDMI
 outputs
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <428154de8d668bb9e8cb73793c51cea361fa4ad8.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Enable the HDMI encoders for the H3 Salvator-X board. The number of
encoders varies between the H3 and M3-W SoCs, so they can't be enabled
in the common salvator-x.dtsi file.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 2a5358b8f229..fcd9ca73f2c7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -58,6 +58,40 @@
 	status = "okay";
 };
 
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
+&hdmi0_con {
+	remote-endpoint = <&rcar_dw_hdmi0_out>;
+};
+
+&hdmi1 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi1_out: endpoint {
+				remote-endpoint = <&hdmi1_con>;
+			};
+		};
+	};
+};
+
+&hdmi1_con {
+	remote-endpoint = <&rcar_dw_hdmi1_out>;
+};
+
 &ohci2 {
 	status = "okay";
 };
-- 
2.1.4
