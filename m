From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:15 +0200
Subject: [PATCH 12/31] arm64: dts: ulcb-kf: enable SCIF1
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <c6c816e22bc89ea4ebfcf04772b4623b573dadc7.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports SCIF1 on ULCB Kingfisher board

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 849f8b102c67..885878a4822c 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -12,6 +12,7 @@
 / {
 	aliases {
 		serial1 = &hscif0;
+		serial2 = &scif1;
 	};
 };
 
@@ -28,4 +29,17 @@
 		groups = "hscif0_data", "hscif0_ctrl";
 		function = "hscif0";
 	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data_b", "scif1_ctrl";
+		function = "scif1";
+	};
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	status = "okay";
 };
-- 
2.11.0
