From: marek@goldelico.com (Marek Belisko)
Date: Sat,  1 Mar 2014 14:58:50 +0100
Subject: [PATCH v2 3/7] ARM: dts: omap3-gta04: Add touchscreen properties
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <1393682334-26805-4-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gta04 using tcs2007 touchscreen. Add support for that.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d9917b8..7f29315 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -130,6 +130,16 @@
 		compatible = "honeywell,hmc5843";
 		reg = <0x1e>;
 	};
+
+	/* touchscreen */
+	tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <600>;
+	};
 };
 
 &i2c3 {
-- 
1.8.3.2
