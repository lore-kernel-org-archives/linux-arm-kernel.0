From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  9 Jan 2017 12:55:28 -0800
Subject: [PATCH v2 3/6] ARM: dts: davinci: da850-lcdk: enable VPIF
In-Reply-To: <20170109205531.3435-1-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
Message-ID: <20170109205531.3435-4-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable VPIF for video captpure and configure input channel 0, used for
composite input.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb4821deb1..9b1f3695607c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -236,3 +236,16 @@
 &memctrl {
 	status = "okay";
 };
+
+&vpif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vpif_capture_pins>;
+	status = "okay";
+
+	/* VPIF capture port */
+	port {
+		vpif_ch0: endpoint {
+			  bus-width = <8>;
+		};
+	};
+};
-- 
2.9.3
