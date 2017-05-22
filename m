From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:03 +0200
Subject: [PATCH 2/3] ARM: dts: r7s72100: add Renesas RZ/A1 pinctrl header
In-Reply-To: <cover.1495454780.git.horms+renesas@verge.net.au>
References: <cover.1495454780.git.horms+renesas@verge.net.au>
Message-ID: <62c2f988d73433cf0706ccc74d3d13588623b9fc.1495454780.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add dt-bindings for Renesas r7s72100 pin controller header file.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/pinctrl/r7s72100-pinctrl.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/r7s72100-pinctrl.h

diff --git a/include/dt-bindings/pinctrl/r7s72100-pinctrl.h b/include/dt-bindings/pinctrl/r7s72100-pinctrl.h
new file mode 100644
index 000000000000..6b609fe10910
--- /dev/null
+++ b/include/dt-bindings/pinctrl/r7s72100-pinctrl.h
@@ -0,0 +1,16 @@
+/*
+ * Defines macros and constants for Renesas RZ/A1 pin controller pin
+ * muxing functions.
+ */
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H
+#define __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H
+
+#define RZA1_PINS_PER_PORT	16
+
+/*
+ * Create the pin index from its bank and position numbers and store in
+ * the upper 16 bits the alternate function identifier
+ */
+#define RZA1_PINMUX(b, p, f)	((b) * RZA1_PINS_PER_PORT + (p) | (f << 16))
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H */
-- 
2.1.4
