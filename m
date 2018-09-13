From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:27 +0200
Subject: [PATCH 04/13] ARM: dts: iwg23s-sbc: Add pinctl support for scif1
In-Reply-To: <cover.1536824376.git.horms+renesas@verge.net.au>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
Message-ID: <01a12d4975fb09c10f64cb551d4903dacd032b79.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Adding pinctrl support for scif1 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index e3585daafdd6..56182eec81fb 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -43,6 +43,16 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif1_pins: scif1 {
+		groups = "scif1_data_b";
+		function = "scif1";
+	};
+};
+
 &scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.11.0
