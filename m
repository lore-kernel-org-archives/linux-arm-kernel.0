From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Sep 2014 10:30:36 +0100
Subject: [PATCH v3 2/4] phy: phy-stih41x-usb: Add dt documentation for USB phy
 on STiH415/6
In-Reply-To: <1410168638-11072-1-git-send-email-peter.griffin@linaro.org>
References: <1410168638-11072-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1410168638-11072-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt documentation bindings for the usb phy found
on STiH415/5 SoC's from STMicroelectronics, which support USB 1.1 and 2.0.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/phy/phy-stih41x-usb.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
new file mode 100644
index 0000000..00944a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
@@ -0,0 +1,24 @@
+STMicroelectronics STiH41x USB PHY binding
+------------------------------------------
+
+This file contains documentation for the usb phy found in STiH415/6 SoCs from
+STMicroelectronics.
+
+Required properties:
+- compatible	: should be "st,stih416-usb-phy" or "st,stih415-usb-phy"
+- st,syscfg	: should be a phandle of the syscfg node
+- clock-names	: must contain "osc_phy"
+- clocks	: must contain an entry for each name in clock-names.
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- #phy-cells	: must be 0 for this phy
+See: Documentation/devicetree/bindings/phy/phy-bindings.txt
+
+Example:
+
+usb2_phy: usb2phy at 0 {
+	compatible	= "st,stih416-usb-phy";
+	#phy-cell	= <0>;
+	st,syscfg	= <&syscfg_rear>;
+	clocks		= <&clk_sysin>;
+	clock-names	= "osc_phy";
+};
-- 
1.9.1
