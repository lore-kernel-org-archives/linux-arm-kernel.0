From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 15:26:52 +0200
Subject: [PATCH 2/2] pinctrl: stm32: move gpio irqs binding to optional
In-Reply-To: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
References: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476970012-7838-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32 pinctrl driver could be probed even if no interrupt controller
is defined to manage gpio irqs. Entries related to gpio irq management
are moved to optional.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index f9753c4..b24583a 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -14,11 +14,6 @@ Required properies:
  - #size-cells	: The value of this property must be 1
  - ranges	: defines mapping between pin controller node (parent) to
    gpio-bank node (children).
- - interrupt-parent: phandle of the interrupt parent to which the external
-   GPIO interrupts are forwarded to.
- - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
-   which includes IRQ mux selection register, and the offset of the IRQ mux
-   selection register.
  - pins-are-numbered: Specify the subnodes are using numbered pinmux to
    specify pins.
 
@@ -37,6 +32,11 @@ Required properties:
 
 Optional properties:
  - reset:	  : Reference to the reset controller
+ - interrupt-parent: phandle of the interrupt parent to which the external
+   GPIO interrupts are forwarded to.
+ - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
+   which includes IRQ mux selection register, and the offset of the IRQ mux
+   selection register.
 
 Example:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
-- 
1.9.1
