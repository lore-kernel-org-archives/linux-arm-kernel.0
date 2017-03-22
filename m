From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 22 Mar 2017 14:36:22 +0100
Subject: [PATCH v1 1/5] dt-bindings: Document STM32 IWDG bindings
In-Reply-To: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
References: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490189786-19232-2-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yannick Fertre <yfertre.stm32@gmail.com>

This adds documentation of device tree bindings for the STM32 IWDG
(Independent WatchDoG).

Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558
Signed-off-by: Yannick Fertre <yfertre.stm32@gmail.com>
Reviewed-on: https://gerrit.st.com/45217
Reviewed-by: Yannick FERTRE <yannick.fertre@st.com>
Tested-by: Yannick FERTRE <yannick.fertre@st.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
new file mode 100644
index 0000000..9c6936b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -0,0 +1,15 @@
+STM32 Independent WatchDoG (IWDG)
+---------------------------------
+
+Required properties:
+- compatible: "st,stm32-iwdg".
+- reg: physical base address and length of the registers set for the device;
+- clocks: Must contain a single entry describing the clock input
+
+Example:
+
+iwdg at 40003000 {
+	compatible = "st,stm32-iwdg";
+	reg = <0x40003000 0x400>;
+	clocks = <&clk_lsi>;
+};
-- 
1.9.1
