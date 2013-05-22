From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 22 May 2013 12:40:33 +0530
Subject: [PATCH 10/11] ARM: davinci: da850: add GPIO DT entries
In-Reply-To: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1369206634-6778-11-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KV Sujith <sujithkv@ti.com>

Add DT entries for Davinci GPIO.

Signed-off-by: KV Sujith <sujithkv@ti.com>
Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 452bdc6..9014eba 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -126,6 +126,15 @@
 				>;
 			};
 		};
+		gpio: gpio at 1e26000 {
+			compatible = "ti,da830-gpio";
+			reg = <0x226000 0x1000>;
+			interrupts = <42>;
+			ngpio = <144>;
+			intc_irq_num = <101>;
+			gpio_unbanked = <0>;
+			status = "disabled";
+		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-- 
1.7.9.5
