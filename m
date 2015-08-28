From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 11:31:49 +0100
Subject: [PATCH v2 2/4] remoteproc: dt: Provide bindings for ST's Remote
 Processor Controller driver
In-Reply-To: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1440757911-9120-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/remoteproc/st-rproc.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
new file mode 100644
index 0000000..fbd7d78
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
@@ -0,0 +1,35 @@
+STMicroelectronics Remote Processor
+-----------------------------------
+
+This binding provides support for adjunct processors found on ST SoCs.
+
+The remote processors can be controlled from the bootloader or the primary OS.
+If the bootloader starts a remote processor processor the primary OS must detect
+its state and act accordingly.
+
+Required properties:
+- compatible		Should be one of:
+				"st,st231-rproc"
+				"st,st40-rproc"
+- reg			Size and length of reserved co-processor memory
+- resets		Reset lines (See: ../reset/reset.txt)
+- reset-names		Must be "sw_reset" and "pwr_reset"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Must be "rproc_clk"
+- clock-frequency	Clock frequency to set co-processor at if the bootloader
+			hasn't already done so
+- st,syscfg-boot	The register that holds the boot vector for the co-processor
+
+Example:
+
+	st231-audio at bae00000 {
+		compatible	= "st,st231-rproc";
+		reg		= <0xbae00000 0x01000000>;
+		reg-names	= "rproc_mem";
+		resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
+		reset-names	= "sw_reset";
+		clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+		clock-names	= "rproc_clk";
+		clock-frequency	= <600000000>;
+		st,syscfg-boot	= <&syscfg_core 0x228>;
+	};
-- 
1.9.1
