From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 18 Nov 2013 19:18:59 +0200
Subject: [PATCH 6/6] arm: dts: keystone: add watchdog entry
In-Reply-To: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1384795139-19466-7-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog entry to keystone device tree.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/boot/dts/keystone.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 100bdf5..a6e5f91 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -179,5 +179,11 @@
 			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
 		};
+
+		wdt: wdt at 022f0080 {
+			compatible = "ti,keystone-wdt";
+			reg = <0x022f0080 0x80>;
+			clocks = <&clkwdtimer0>;
+		};
 	};
 };
-- 
1.7.9.5
