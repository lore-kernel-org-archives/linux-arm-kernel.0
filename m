From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 17 Jul 2018 11:56:26 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: add syscfg mask parameter
In-Reply-To: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds mask parameter to define IRQ mux field.
This field could vary depend of IRQ mux selection register.
This parameter is needed if the mask is different of 0xf.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 9a06e1f..4d60119 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -39,9 +39,10 @@ Optional properties:
  - reset:	  : Reference to the reset controller
  - interrupt-parent: phandle of the interrupt parent to which the external
    GPIO interrupts are forwarded to.
- - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
-   which includes IRQ mux selection register, and the offset of the IRQ mux
-   selection register.
+ - st,syscfg: Should be phandle/offset/mask.
+	-The phandle to the syscon node which includes IRQ mux selection register.
+	-The offset of the IRQ mux selection register
+	-The field mask of IRQ mux, needed if different of 0xf.
  - gpio-ranges: Define a dedicated mapping between a pin-controller and
    a gpio controller. Format is <&phandle a b c> with:
 	-(phandle): phandle of pin-controller.
-- 
2.7.4
