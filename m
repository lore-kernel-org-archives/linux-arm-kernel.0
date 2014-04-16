From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 16 Apr 2014 21:13:13 +0400
Subject: [PATCH v4 03/21] ARM: dts: fix pxa27x-gpio interrupts
In-Reply-To: <1397668411-27162-1-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1397668411-27162-1-git-send-email-ynvich@gmail.com>
Message-ID: <1397668411-27162-4-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Haojian Zhuang <haojian.zhuang@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v3..v4
   v2..v3
   v1..v2
   * no changes

 arch/arm/boot/dts/pxa27x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a705469..39bed5e 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -34,5 +34,11 @@
 			reg = <0x40c00010 0x10>;
 			#pwm-cells = <1>;
 		};
+
+		gpio: gpio at 40e00000 {
+			compatible = "intel,pxa27x-gpio";
+			interrupts = <8>, <9>, <10>;
+			interrupt-names = "gpio0", "gpio1", "gpio_mux";
+		};
 	};
 };
-- 
1.8.4.2
