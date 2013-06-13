From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:51:03 +0800
Subject: [PATCH 8/9] ARM: dtsi: imx6qdl-sabresd: Enable WM8962 audio support
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <ff376e7cbb44461c983b1dc1fc98bc1cc58cf9c4.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable WM8962 ALSA machine driver via devicetree.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a76e37a..dc755c4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -50,6 +50,25 @@
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx6q-sabresd-wm8962",
+			   "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"MICBIAS", "AMIC",
+			"IN3R", "MICBIAS",
+			"DMIC", "MICBIAS",
+			"DMICDAT", "DMIC";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
 };
 
 &fec {
-- 
1.7.1
