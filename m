From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:05 +0200
Subject: [PATCH 02/15] ARM: sunxi: dt: document pinctrl clock related
 properties
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document clocks and clock-names properties for the pinctrl driver.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 0e7e9a1..b3e5c30 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -15,6 +15,10 @@ Required properties:
   "allwinner,sun7i-a20-pinctrl"
 - reg: Should contain the register physical address and length for the
   pin controller.
+- clocks: Should contain a list of gate clk needed by the pin controller
+- clock-names: Should at least contain "pio_clk" which is used by the
+  base pin controller. In case of sun6i-a31 SoC, this property should
+  also contain the "pioL_clk" string.
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices.
-- 
1.8.3.2
