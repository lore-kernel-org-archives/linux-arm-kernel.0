From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  9 Jan 2017 12:55:27 -0800
Subject: [PATCH v2 2/6] ARM: dts: davinci: da850-evm: enable VPIF
In-Reply-To: <20170109205531.3435-1-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
Message-ID: <20170109205531.3435-3-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable VPIF node for video capture, and configure ports.  EVM board
uses channel 0 for composite input and channel 1 S-Video input.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 41de15fe15a2..cea36ee6fd07 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -289,3 +289,23 @@
 		};
 	};
 };
+
+&vpif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vpif_capture_pins>;
+	status = "okay";
+
+	/* VPIF capture port */
+	port {
+		vpif_ch0: endpoint at 0 {
+			  reg = <0>;
+			  bus-width = <8>;
+		};
+
+		vpif_ch1: endpoint at 1 {
+			  reg = <1>;
+			  bus-width = <8>;
+			  data-shift = <8>;
+		};
+	};
+};
-- 
2.9.3
