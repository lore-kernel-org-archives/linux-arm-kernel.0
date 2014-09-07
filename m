From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Sep 2014 19:19:34 +0200
Subject: [PATCH v6 6/7] am33xx: define syscon control module device node
In-Reply-To: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1410110375-3570-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161342ba..25e38b6ac376 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -132,6 +132,11 @@
 			};
 		};
 
+		cm: syscon at 44e10000 {
+			compatible = "ti,am33xx-controlmodule", "syscon";
+			reg = <0x44e10000 0x800>;
+		};
+
 		intc: interrupt-controller at 48200000 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
-- 
2.1.0
