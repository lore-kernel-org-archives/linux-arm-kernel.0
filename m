From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  8 Jun 2012 17:01:59 +0300
Subject: [PATCH 1/7] arm/dts: omap4: Add entry for OMAP McPDM IP
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339164125-32534-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McPDM is used on OMAP4 based boards to communicate with an external audio
codec (twl6040).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..4c43f3b 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,14 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		mcpdm: mcpdm at 40132000 {
+			compatible = "ti,omap4-mcpdm";
+			reg = <0x40132000 0x7f>, /* MPU private access */
+			      <0x49032000 0x7f>; /* L3 Interconnect */
+			interrupts = <0 112 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "mcpdm";
+		};
 	};
 };
-- 
1.7.8.6
