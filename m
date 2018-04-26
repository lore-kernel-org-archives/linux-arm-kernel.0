From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Thu, 26 Apr 2018 17:53:46 +0100
Subject: [PATCH 17/17] arm64: dts: r8a77965-salvator-xs: Enable HDMI output
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <20180426165346.494-18-kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables the HDMI encoder for the Salvator-X 2nd version board
on the R8A77965 SoC and hook it up to the HDMI connector.

Based on code of the Salvator-X 2nd version board
on the R8A7796 SoC device tree
by Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 .../boot/dts/renesas/r8a77965-salvator-xs.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 2223cc2bd6bc..dcf1849f1a67 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -31,3 +31,20 @@
 	clock-names = "du.0", "du.1", "du.3", "lvds.0",
 		      "dclkin.0", "dclkin.1", "dclkin.3";
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
2.17.0
