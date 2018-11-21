From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:46 -0800
Subject: [PATCH v8 1/7] ASoC: dt-bindings: add regulator property to simple
 amplifier
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Message-ID: <20181121051752.18387-2-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amplifier may have associated regulator, so add a property for it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
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
