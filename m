From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Dec 2016 09:50:51 +0100
Subject: [PATCHv2 2/8] dt-bindings: document the STM32 RTC bindings
In-Reply-To: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
References: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1481878257-29163-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32 RTC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
new file mode 100644
index 0000000..e2837b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -0,0 +1,27 @@
+STM32 Real Time Clock
+
+Required properties:
+- compatible: "st,stm32-rtc".
+- reg: address range of rtc register set.
+- clocks: reference to the clock entry ck_rtc.
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
+  (RTC registers) write protection.
+
+Optional properties (to override default ck_rtc parent clock):
+- assigned-clocks: reference to the ck_rtc clock entry.
+- assigned-clock-parents: phandle of the new parent clock of ck_rtc.
+
+Example:
+
+	rtc: rtc at 40002800 {
+		compatible = "st,stm32-rtc";
+		reg = <0x40002800 0x400>;
+		clocks = <&rcc 1 CLK_RTC>;
+		assigned-clocks = <&rcc 1 CLK_RTC>;
+		assigned-clock-parents = <&rcc 1 CLK_LSE>;
+		interrupt-parent = <&exti>;
+		interrupts = <17 1>;
+		st,syscfg = <&pwrcfg>;
+	};
-- 
1.9.1
