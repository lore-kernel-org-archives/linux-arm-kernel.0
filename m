From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 17:47:21 +0100
Subject: [PATCH 5/6] arm: dts: am33xx, Add device node for cpsw-ctrl-macid
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387385242-1161-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6d8ffe..4e1bf08 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -676,6 +676,13 @@
 				reg= <0x44e10650 0x4>;
 				reg-names = "gmii-sel";
 			};
+
+			cpsw_ctrl_macid: cpsw-ctrl-macid at 44e10630 {
+				compatible = "ti,am3352-cpsw-ctrl-macid";
+				#ti,mac-address-ctrl-cells = <1>;
+				reg = <0x44e10630 0x16>;
+				reg-names = "ctrl-macid";
+			};
 		};
 
 		ocmcram: ocmcram at 40300000 {
-- 
1.8.5.1
