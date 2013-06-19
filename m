From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 18 Jun 2013 22:36:38 -0400
Subject: [PATCH 1/1] arm: add bandgap DT entry for OMAP5
Message-ID: <1371609398-26454-1-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bandgap device DT entry for OMAP5 dtsi.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)
---

Benoit,

Sorry for this very late request, but can you please consider
these patches for 3.11 still?

I completely forgot to send these on my "Enable TI SoC thermal driver" series.

All best,

Eduardo

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 2ad63c4..5ede6e1 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -615,5 +615,13 @@
 			interrupts = <0 80 0x4>;
 			ti,hwmods = "wd_timer2";
 		};
+		bandgap {
+			reg = <0x4a0021e0 0xc
+				0x4a00232c 0xc
+				0x4a002380 0x2c
+				0x4a0023C0 0x3c>;
+				interrupts = <0 126 4>; /* talert */
+			compatible = "ti,omap5430-bandgap";
+		};
 	};
 };
-- 
1.8.2.1.342.gfa7285d
