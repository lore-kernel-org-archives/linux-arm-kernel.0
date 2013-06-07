From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 7 Jun 2013 16:46:06 -0400
Subject: [PATCHv3 4/6] arm: dts: add bandgap entry for OMAP4460 devices
In-Reply-To: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1370637968-23299-5-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include bandgap devices for OMAP4460 devices.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 2cf227c..ea97201 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -29,4 +29,13 @@
 			     <0 55 0x4>;
 		ti,hwmods = "debugss";
 	};
+
+	bandgap {
+		reg = <0x4a002260 0x4
+			0x4a00232C 0x4
+			0x4a002378 0x18>;
+		compatible = "ti,omap4460-bandgap";
+		interrupts = <0 126 4>; /* talert */
+		gpios = <&gpio3 22 0>; /* tshut */
+	};
 };
-- 
1.8.2.1.342.gfa7285d
