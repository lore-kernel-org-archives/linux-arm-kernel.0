From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 16 Aug 2014 17:18:34 +0200
Subject: [PATCH v3 6/7] am33xx: define syscon control module device node
In-Reply-To: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1408202315-20006-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d0ce9e..cb1113bcc290 100644
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
2.0.1
