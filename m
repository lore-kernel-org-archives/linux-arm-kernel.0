From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu, 16 Feb 2017 19:05:04 +0800
Subject: [PATCH v2 1/3] ASoC: zx-tdm: add bindings doc for zte's tdm controller
Message-ID: <1487243106-22841-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for zte's tdm controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/sound/zte,tdm.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,tdm.txt b/Documentation/devicetree/bindings/sound/zte,tdm.txt
new file mode 100644
index 0000000..8ffc39e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,tdm.txt
@@ -0,0 +1,30 @@
+ZTE TDM DAI driver
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-tdm
+- reg : physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "wclk" for the wclk.
+               "pclk" for the pclk.
+-#clock-cells: should be 1.
+- zte,tdm-dma-sysctrl : Reference to the sysctrl controller controlling
+    the dma. includes:
+	phandle of sysctrl.
+	register offset in sysctrl for control dma.
+	mask of the register that be written to sysctrl.
+
+Example:
+
+	tdm: tdm at 1487000 {
+		compatible = "zte,zx296718-tdm";
+		reg = <0x01487000 0x1000>;
+		clocks = <&audiocrm AUDIO_TDM_WCLK>, <&audiocrm AUDIO_TDM_PCLK>;
+		clock-names = "wclk", "pclk";
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tdm_global_pin>;
+		zte,tdm-dma-sysctrl = <&sysctrl 0x10c 4>;
+	};
-- 
2.7.4
