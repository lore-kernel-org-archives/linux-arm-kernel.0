From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Fri, 31 Aug 2018 20:14:36 +0300
Subject: [PATCH v2 2/2] ASoC: mikroe-proto: dt-bindings: add DT bindings for
 PROTO board
In-Reply-To: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
References: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180831171436.13360-3-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - adjusted "mikroe" position in vendor-prefixes.txt;

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
index 2c3fc512e746..f26bf667e530 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -235,6 +235,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
-- 
2.17.1
