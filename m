From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:05 +0200
Subject: [PATCH 13/31] arm64: dts: r8a7796: salvator-x: Enable HDMI output
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <3b390386d7c619ca31ef25c3d04af131795b1017.1501509525.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Enable the HDMI encoder for the M3-W Salvator-X board and hook it up to
the HDMI connector.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index fe2743bcb616..b317be03306e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -39,3 +39,20 @@
 	clock-names = "du.0", "du.1", "du.2", "lvds.0",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
+
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
-- 
2.1.4
