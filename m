From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  8 Jun 2012 17:02:00 +0300
Subject: [PATCH 2/7] arm/dts: omap4: Add entry for OMAP DMIC IP
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339164125-32534-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMIC IP is used to connect up to 6 digital microphones directly to OMAP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c43f3b..fb0287d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -281,5 +281,14 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "mcpdm";
 		};
+
+		dmic: dmic at 4012e000 {
+			compatible = "ti,omap4-dmic";
+			reg = <0x4012e000 0x7f>, /* MPU private access */
+			      <0x4902e000 0x7f>; /* L3 Interconnect */
+			interrupts = <0 114 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "dmic";
+		};
 	};
 };
-- 
1.7.8.6
