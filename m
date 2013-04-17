From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 17 Apr 2013 16:29:34 -0400
Subject: [PATCH 3/3] arm: add bandgap entry for OMAP4460 devices
In-Reply-To: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
References: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1366230574-31547-4-git-send-email-eduardo.valentin@ti.com>
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
index 7c2c23c..3808b5c 100644
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
+		ti,tshut-gpio = <86>;
+	};
 };
-- 
1.8.2.1.342.gfa7285d
