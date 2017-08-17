From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Aug 2017 16:09:09 +0100
Subject: [PATCH ] ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
Message-ID: <1502982549-19429-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding pinctrl support for scif4 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch depends upon the below patch series
[PATCH  0/2] ARM: dts: Add iWave RZ/G1E board support
http://www.spinics.net/lists/devicetree/msg190513.html

This patch is tested against renesas-dev tag 
renesas-devel-20170815-v4.13-rc5 + above dependency patch.

 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index cbc19fe..442a5cb 100644
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
1.9.1
