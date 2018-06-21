From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 21 Jun 2018 11:02:14 +0200
Subject: [PATCH V4 1/4] dt-bindings: watchdog: add stm32mp1 support
In-Reply-To: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of stm32mp1.
stm32mp1 requires 2 clocks lsi and pclk.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
index cc13b10a..d8f4430 100644
--- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -2,9 +2,15 @@ STM32 Independent WatchDoG (IWDG)
 ---------------------------------
 
 Required properties:
-- compatible: "st,stm32-iwdg"
-- reg: physical base address and length of the registers set for the device
-- clocks: must contain a single entry describing the clock input
+- compatible: Should be either:
+  - "st,stm32-iwdg"
+  - "st,stm32mp1-iwdg"
+- reg: Physical base address and length of the registers set for the device
+- clocks: Reference to the clock entry lsi. Additional pclk clock entry
+  is required only for st,stm32mp1-iwdg.
+- clock-names: Name of the clocks used.
+  "lsi" for st,stm32-iwdg
+  "lsi", "pclk" for st,stm32mp1-iwdg
 
 Optional Properties:
 - timeout-sec: Watchdog timeout value in seconds.
@@ -15,5 +21,6 @@ iwdg: watchdog at 40003000 {
 	compatible = "st,stm32-iwdg";
 	reg = <0x40003000 0x400>;
 	clocks = <&clk_lsi>;
+	clock-names = "lsi";
 	timeout-sec = <32>;
 };
-- 
2.7.4
