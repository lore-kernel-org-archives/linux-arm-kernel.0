From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 25 Nov 2013 16:54:59 +0200
Subject: [PATCH v3 6/6] arm: dts: keystone: add watchdog entry
In-Reply-To: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1385391299-27326-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog entry to keystone device tree.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/boot/dts/keystone.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index f6d6d9e..54a8ff7 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -181,5 +181,11 @@
 			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
 		};
+
+		wdt: wdt at 022f0080 {
+			compatible = "ti,keystone-wdt","ti,davinci-wdt";
+			reg = <0x022f0080 0x80>;
+			clocks = <&clkwdtimer0>;
+		};
 	};
 };
-- 
1.7.9.5
