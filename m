From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Aug 2016 15:43:47 +0200
Subject: [PATCH v3 5/6] documentation: Add nvmem bindings documentation
In-Reply-To: <1472305428-16874-1-git-send-email-carlo@caione.org>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
Message-ID: <1472305428-16874-6-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch add the bindings document of Amlogic eFuse driver.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
new file mode 100644
index 0000000..fafd85b
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
@@ -0,0 +1,39 @@
+= Amlogic eFuse device tree bindings =
+
+Required properties:
+- compatible: should be "amlogic,meson-gxbb-efuse"
+
+= Data cells =
+Are child nodes of eFuse, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sn: sn at 14 {
+			reg = <0x14 0x10>;
+		};
+
+		eth_mac: eth_mac at 34 {
+			reg = <0x34 0x10>;
+		};
+
+		bid: bid at 46 {
+			reg = <0x46 0x30>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	eth_mac {
+		...
+		nvmem-cells = <&eth_mac>;
+		nvmem-cell-names = "eth_mac";
+	};
-- 
2.7.4
