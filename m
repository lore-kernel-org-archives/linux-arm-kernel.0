From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:18 +0200
Subject: [PATCH 26/48] ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <67dbb081815e013e1e7911305b43b44537a78ed2.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Adding pinctrl support for scif4 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index cbc19feb1565..442a5cbb0838 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -24,6 +24,16 @@
 	};
 };
 
+&pfc {
+	scif4_pins: scif4 {
+		groups = "scif4_data_b";
+		function = "scif4";
+	};
+};
+
 &scif4 {
+	pinctrl-0 = <&scif4_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.1.4
