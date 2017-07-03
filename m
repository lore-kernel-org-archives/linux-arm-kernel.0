From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 3 Jul 2017 10:41:23 +0200
Subject: [PATCH v5 3/7] dt-bindings: display: Add Synopsys DW MIPI DSI host
 controller
In-Reply-To: <1499071287-10414-1-git-send-email-philippe.cornu@st.com>
References: <1499071287-10414-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1499071287-10414-4-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the
Synopsys DesignWare MIPI DSI host controller.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 .../bindings/display/bridge/dw_mipi_dsi.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
new file mode 100644
index 0000000..b13adf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
@@ -0,0 +1,32 @@
+Synopsys DesignWare MIPI DSI host controller
+============================================
+
+This document defines device tree properties for the Synopsys DesignWare MIPI
+DSI host controller. It doesn't constitue a device tree binding specification
+by itself but is meant to be referenced by platform-specific device tree
+bindings.
+
+When referenced from platform device tree bindings the properties defined in
+this document are defined as follows. The platform device tree bindings are
+responsible for defining whether each optional property is used or not.
+
+- reg: Memory mapped base address and length of the DesignWare MIPI DSI
+  host controller registers. (mandatory)
+
+- clocks: References to all the clocks specified in the clock-names property
+  as specified in [1]. (mandatory)
+
+- clock-names:
+  - "pclk" is the peripheral clock for either AHB and APB. (mandatory)
+  - "px_clk" is the pixel clock for the DPI/RGB input. (optional)
+
+- resets: References to all the resets specified in the reset-names property
+  as specified in [2]. (optional)
+
+- reset-names: string reset name, must be "apb" if used. (optional)
+
+- panel or bridge node: see [3]. (mandatory)
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/reset/reset.txt
+[3] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
-- 
1.9.1
