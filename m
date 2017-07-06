From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  6 Jul 2017 12:27:50 +0200
Subject: [PATCH 2/2] dt-bindings: media: Add Amlogic Meson AO-CEC bindings
In-Reply-To: <1499336870-24118-1-git-send-email-narmstrong@baylibre.com>
References: <1499336870-24118-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1499336870-24118-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic SoCs embeds a standalone CEC Controller, this patch adds this
device bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/media/meson-ao-cec.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ao-cec.txt

diff --git a/Documentation/devicetree/bindings/media/meson-ao-cec.txt b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
new file mode 100644
index 0000000..8671bdb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
@@ -0,0 +1,28 @@
+* Amlogic Meson AO-CEC driver
+
+The Amlogic Meson AO-CEC module is present is Amlogic SoCs and its purpose is
+to handle communication between HDMI connected devices over the CEC bus.
+
+Required properties:
+  - compatible : value should be following
+	"amlogic,meson-gx-ao-cec"
+
+  - reg : Physical base address of the IP registers and length of memory
+	  mapped region.
+
+  - interrupts : AO-CEC interrupt number to the CPU.
+  - clocks : from common clock binding: handle to AO-CEC clock.
+  - clock-names : from common clock binding: must contain "core",
+		  corresponding to entry in the clocks property.
+  - hdmi-phandle: phandle to the HDMI controller
+
+Example:
+
+cec_AO: cec at 100 {
+	compatible = "amlogic,meson-gx-ao-cec";
+	reg = <0x0 0x00100 0x0 0x14>;
+	interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_AO CLKID_AO_CEC_32K>;
+	clock-names = "core";
+	hdmi-phandle = <&hdmi_tx>;
+};
-- 
1.9.1
