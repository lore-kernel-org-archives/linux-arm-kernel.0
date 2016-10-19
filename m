From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 19 Oct 2016 09:12:05 -0700
Subject: [PATCH v5 2/2] Documentation: DT: MMC: meson-gx: new bindings doc
In-Reply-To: <20161019161205.28565-1-khilman@baylibre.com>
References: <20161019161205.28565-1-khilman@baylibre.com>
Message-ID: <20161019161205.28565-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
new file mode 100644
index 000000000000..a2fa9a1c26ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -0,0 +1,33 @@
+Amlogic SD / eMMC controller for S905/GXBB family SoCs
+
+The MMC 5.1 compliant host controller on Amlogic provides the
+interface for SD, eMMC and SDIO devices.
+
+This file documents the properties in addition to those available in
+the MMC core bindings, documented by mmc.txt.
+
+Required properties:
+- compatible : contains one of:
+  - "amlogic,meson-gx-mmc"
+  - "amlogic,meson-gxbb-mmc"
+  - "amlogic,meson-gxl-mmc"
+  - "amlogic,meson-gxm-mmc"
+- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
+- clock-names: Should contain the following:
+	"core" - Main peripheral bus clock
+	"clkin0" - Parent clock of internal mux
+	"clkin1" - Other parent clock of internal mux
+  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
+  clock rate requested by the MMC core.
+
+Example:
+
+	sd_emmc_a: mmc at 70000 {
+        	compatible = "amlogic,meson-gxbb-mmc";
+		reg = <0x0 0x70000 0x0 0x2000>;
+                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "clkin0", "clkin1";
+		pinctrl-0 = <&emmc_pins>;
+	};
+
-- 
2.9.3
