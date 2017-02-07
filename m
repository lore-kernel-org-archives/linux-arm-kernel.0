From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue,  7 Feb 2017 17:41:17 +0100
Subject: [PATCH 04/10] ARM: dts: da850-evm: add the output port to the vpif
 node
In-Reply-To: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1486485683-11427-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the vpif node with an output port with a single channel.

NOTE: this is still just hardware description - the actual driver
is registered using pdata-quirks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 14 +++++++++++---
 arch/arm/boot/dts/da850.dtsi    |  8 +++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 94938a3..3d6dd66 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -299,16 +299,24 @@
 	status = "okay";
 
 	/* VPIF capture port */
-	port {
-		vpif_ch0: endpoint at 0 {
+	port at 0 {
+		vpif_input_ch0: endpoint at 0 {
 			reg = <0>;
 			bus-width = <8>;
 		};
 
-		vpif_ch1: endpoint at 1 {
+		vpif_input_ch1: endpoint at 1 {
 			reg = <1>;
 			bus-width = <8>;
 			data-shift = <8>;
 		};
 	};
+
+	/* VPIF display port */
+	port at 1 {
+		vpif_output_ch0: endpoint at 0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 69ec5e7..768a58c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -494,7 +494,13 @@
 			status = "disabled";
 
 			/* VPIF capture port */
-			port {
+			port at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			/* VPIF display port */
+			port at 1 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
-- 
2.9.3
