From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:29:01 +0100
Subject: [PATCH 7/9] ARM: dts: omap3-gta04: Add touchscreen properties.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-8-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index f72e408..151ed3b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -150,6 +150,16 @@
 			reg = <0x4>;
 		};
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
