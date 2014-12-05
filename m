From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Fri,  5 Dec 2014 11:38:40 +0800
Subject: [PATCH v4 2/4] ARM: dts: hip04: add GPIO pieces
In-Reply-To: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
References: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <1417750722-14027-3-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon Soc hip04 has four GPIO controllers, each one has 32
GPIOs and can be configured to be an interrupt controller.The GPIO
controllers are compatible with the snps,dw-apb-gpio driver.
This patch add the corresponding device tree nodes.

A new property caller "gpio-number-forward" has been added in
dw-apb-gpio dts node to support to get base number of a GPIO
controller in increasing order.

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 arch/arm/boot/dts/hip04.dtsi |   79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 93b6c90..811ca7b 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -263,5 +263,84 @@
 			interrupts = <0 372 4>;
 		};
 
+		gpio at 4000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4000000 0x1000>;
+			gpio-number-forward;
+
+			gpio0: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 389 4>;
+			};
+		};
+
+		gpio at 4001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4001000 0x1000>;
+			gpio-number-forward;
+
+			gpio1: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 390 4>;
+			};
+		};
+
+		gpio at 4002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4002000 0x1000>;
+			gpio-number-forward;
+
+			gpio2: gpio-controller at 0 {
+			compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 391 4>;
+			};
+		};
+
+		gpio at 4003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4003000 0x1000>;
+			gpio-number-forward;
+
+			gpio3: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 392 4>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
