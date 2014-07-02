From: rongjun.ying@csr.com (Rongjun Ying)
Date: Wed, 2 Jul 2014 10:45:42 +0800
Subject: [PATCH v2 2/2] ASoC: sirf: Add device tree binding for the USP audio
 device
In-Reply-To: <1404269142-3557-1-git-send-email-rongjun.ying@csr.com>
References: <1404269142-3557-1-git-send-email-rongjun.ying@csr.com>
Message-ID: <1404269142-3557-3-git-send-email-rongjun.ying@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-usp.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-usp.txt

diff --git a/Documentation/devicetree/bindings/sound/sirf-usp.txt b/Documentation/devicetree/bindings/sound/sirf-usp.txt
new file mode 100644
index 0000000..02f85b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-usp.txt
@@ -0,0 +1,27 @@
+* SiRF SoC USP module
+
+Required properties:
+- compatible: "sirf,prima2-usp-pcm"
+- reg: Base address and size entries:
+- dmas: List of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+  One of the DMA channels will be responsible for transmission (should be
+  named "tx") and one for reception (should be named "rx").
+
+- clocks: USP controller clock source
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+
+Example:
+usp0: usp at b0080000 {
+	compatible = "sirf,prima2-usp-pcm";
+	reg = <0xb0080000 0x10000>;
+	clocks = <&clks 28>;
+	dmas = <&dmac1 1>, <&dmac1 2>;
+	dma-names = "rx", "tx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usp0_only_utfs_pins_a>;
+};
+
-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
