From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:18 +0100
Subject: [PATCH 48/69] arm64: dts: renesas: r8a77965: Add #interrupt-cells
 property
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <f5af77016bcd80bfe850ca41da51d65bd31f8051.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add "#interrupt-cells" property and "interrupt-controller" label to
"interrupt-controller at e61c0000" device node.

This silences the following DTC compiler warnings:
Warning (interrupts_property): Missing interrupt-controller or
interrupt-map property in /soc/interrupt-controller at e61c0000
Warning (interrupts_property): Missing #interrupt-cells in
interrupt-parent /soc/interrupt-controller at e61c000

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 5dff176590d5..0118956cc6e0 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -316,6 +316,8 @@
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			reg = <0 0xe61c0000 0 0x200>;
 			/* placeholder */
 		};
-- 
2.11.0
