From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Wed, 29 Aug 2018 17:47:27 +0300
Subject: [PATCH 2/2] ASoC: mikroe-proto: dt-bindings: add DT bindings for
 PROTO board
In-Reply-To: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180829144727.13757-3-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mikroe,mikroe-proto.txt    | 23 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt

diff --git a/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
new file mode 100644
index 000000000000..912f8fae11c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
@@ -0,0 +1,23 @@
+Mikroe-PROTO audio board
+
+Required properties:
+  - compatible: "mikroe,mikroe-proto"
+  - dai-format: Must be "i2s".
+  - i2s-controller: The phandle of the I2S controller.
+  - audio-codec: The phandle of the WM8731 audio codec.
+Optional properties:
+  - model: The user-visible name of this sound complex.
+  - bitclock-master: Indicates dai-link bit clock master; for details see simple-card.txt (1).
+  - frame-master: Indicates dai-link frame master; for details see simple-card.txt (1).
+
+(1) : There must be the same master for both bit and frame clocks.
+
+Example:
+	sound {
+		compatible = "mikroe,mikroe-proto";
+		model = "wm8731 @ sama5d2_xplained";
+		i2s-controller = <&i2s0>;
+		audio-codec = <&wm8731>;
+		dai-format = "i2s";
+        };
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f4a98c85340a..8ac3ec1f36e5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -210,6 +210,7 @@ micron	Micron Technology Inc.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
+mikroe		MikroElektronika d.o.o.
 mosaixtech	Mosaix Technologies, Inc.
 motorola	Motorola, Inc.
 moxa	Moxa Inc.
-- 
2.17.1
