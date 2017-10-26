From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 26 Oct 2017 13:48:08 +0200
Subject: [PATCH v1 1/2] dt-bindings: display: stm32: add a 2nd endpoint
In-Reply-To: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
References: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1509018489-19641-2-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ltdc can have up to 2 endpoints:
 - dpi external gpios: for rgb panels or external bridge ICs.
 - dpi internal ios: connected internally to dsi.

Note: Refer to the reference manual to know if the dsi is
present on your device.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 74b5ac7..0292522 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -10,7 +10,11 @@
       - "lcd" for the clock feeding the output pixel clock & IP clock.
   - resets: reset to be used by the device (defined by use of RCC macro).
   Required nodes:
-    - Video port for RGB output.
+  - Video port for DPI RGB output: ltdc has one video port with up to 2
+    endpoints:
+      - for external dpi rgb panel or bridge, using gpios.
+      - for internal dpi input of the MIPI DSI host controller.
+      Note: These 2 endpoints cannot be activated simultaneously.
 
 * STMicroelectronics STM32 DSI controller specific extensions to Synopsys
   DesignWare MIPI DSI host controller
-- 
1.9.1
