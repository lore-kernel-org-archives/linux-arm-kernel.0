From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Nov 2018 18:23:20 +0800
Subject: [PATCH v9 3/8] ASoC: dt-bindings: add regulator property to simple
 amplifier
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Message-ID: <20181122102325.29495-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Amplifier may have associated regulator, so add a property for it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 8647edae7af0..7182ac4f1e65 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -4,9 +4,14 @@ Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
 - enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
+Optional properties:
+- VCC-supply   : power supply for the device, as covered
+                 in Documentation/devicetree/bindings/regulator/regulator.txt
+
 Example:
 
 amp: analog-amplifier {
 	compatible = "simple-audio-amplifier";
+	VCC-supply = <&regulator>;
 	enable-gpios = <&gpio GPIOH_3 0>;
 };
-- 
2.19.1
