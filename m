From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 13 Sep 2016 15:28:12 +0200
Subject: [PATCH] Documentation: dt-bindings: Fix "st,
 syscfg" definition for STM32 pinctrl
Message-ID: <1473773292-10225-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"st,syscfg" entry was bad described.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index a0eed99..f9753c4 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -16,7 +16,9 @@ Required properies:
    gpio-bank node (children).
  - interrupt-parent: phandle of the interrupt parent to which the external
    GPIO interrupts are forwarded to.
- - st,syscfg: phandle of the syscfg node used for IRQ mux selection.
+ - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
+   which includes IRQ mux selection register, and the offset of the IRQ mux
+   selection register.
  - pins-are-numbered: Specify the subnodes are using numbered pinmux to
    specify pins.
 
-- 
1.9.1
