From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:44 +0100
Subject: [PATCH v3 16/24] drm/i2c: tda998x: add DT documentation
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195844.0c975b90@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/drm/i2c/tda998x.txt        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/i2c/tda998x.txt

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
new file mode 100644
index 0000000..72da71d
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -0,0 +1,24 @@
+Device-Tree bindings for the NXP TDA998x HDMI transmitter
+
+Required properties;
+  - compatible: must be "nxp,tda998x"
+
+Optional properties:
+  - interrupts: interrupt number for HDMI exchanges - default: by polling
+
+  - pinctrl-0: pin control group to be used for this controller (IRQ).
+
+  - pinctrl-names: must contain a "default" entry.
+
+  - video-ports: 24 bits value - default: <0x230145>
+
+Example:
+
+	tda998x: hdmi-encoder {
+		compatible = "nxp,tda998x";
+		reg = <0x70>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <27 2>;		/* falling edge */
+		pinctrl-0 = <&pmx_camera>;
+		pinctrl-names = "default";
+	};
-- 
1.8.5.3
