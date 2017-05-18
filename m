From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 18 May 2017 10:42:36 +0200
Subject: [PATCH v3 1/3] watchdog: bindings: dw_wdt: add reset lines
In-Reply-To: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
References: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
Message-ID: <77954d7b338db9956e15298064f21c028c2070f3.1495096910.git-series.s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the reset lines holding the watchdog core in reset.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog at vger.kernel.org
Cc: devicetree at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
index 08e16f684f2d..eb0914420c7c 100644
--- a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -10,6 +10,8 @@ Required Properties:
 Optional Properties:
 
 - interrupts	: The interrupt used for the watchdog timeout warning.
+- resets	: phandle pointing to the system reset controller with
+		line index for the watchdog.
 
 Example:
 
@@ -18,4 +20,5 @@ Example:
 		reg = <0xffd02000 0x1000>;
 		interrupts = <0 171 4>;
 		clocks = <&per_base_clk>;
+		resets = <&rst WDT0_RESET>;
 	};
-- 
git-series 0.9.1
