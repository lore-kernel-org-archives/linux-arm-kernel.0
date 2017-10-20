From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:25 +0200
Subject: [PATCH 22/31] arm64: dts: ulcb-kf: hog USB3 hub control gpios
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <4339306acef642af151ae9c7ec4c39d0cae28497.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This adds gpio hogs for USB3 hub on ULCB Kingfisher board to power up and
remove from reset the hub

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 1923e5b8ee86..657ad1041965 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -53,6 +53,20 @@
 		interrupt-controller;
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		hub_pwen {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "HUB pwen";
+		};
+
+		hub_rst {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "HUB rst";
+		};
 	};
 
 	gpio_exp_75: gpio at 75 {
-- 
2.11.0
