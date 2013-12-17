From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 17 Dec 2013 23:37:33 +0400
Subject: [PATCH v3 03/21] ARM: dts: fix pxa27x-gpio interrupts
In-Reply-To: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Message-ID: <1387309071-22382-4-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v2..v3
   v1..v2
   * no changes

 arch/arm/boot/dts/pxa27x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index d7c5d72..44df554 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -10,5 +10,11 @@
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
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
