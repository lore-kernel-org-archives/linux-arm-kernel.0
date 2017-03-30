From: yannick.fertre@st.com (Yannick Fertre)
Date: Thu, 30 Mar 2017 17:15:22 +0200
Subject: [PATCH v4 1/5] dt-bindings: watchdog: Document STM32 IWDG bindings
In-Reply-To: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
References: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490886926-20585-2-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the STM32 IWDG
(Independent WatchDoG).

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Author:    Yannick Fertre <yannick.fertre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
new file mode 100644
index 0000000..15fef87
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -0,0 +1,15 @@
+STM32 Independent WatchDoG (IWDG)
+---------------------------------
+
+Required properties:
+- compatible: "st,stm32-iwdg"
+- reg: physical base address and length of the registers set for the device
+- clocks: must contain a single entry describing the clock input
+
+Example:
+
+iwdg: watchdog at 40003000 {
+	compatible = "st,stm32-iwdg";
+	reg = <0x40003000 0x400>;
+	clocks = <&clk_lsi>;
+};
-- 
1.9.1
