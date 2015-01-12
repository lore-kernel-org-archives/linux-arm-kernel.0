From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 12 Jan 2015 15:05:12 +0800
Subject: [PATCH v6 2/2] ARM: dts: hip04: add GPIO pieces
In-Reply-To: <1421046312-22170-1-git-send-email-wangzhou1@hisilicon.com>
References: <1421046312-22170-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1421046312-22170-3-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon Soc hip04 has four GPIO controllers, each one has 32
GPIOs and can be configured to be an interrupt controller.The GPIO
controllers are compatible with the snps,dw-apb-gpio driver.
This patch add the corresponding device tree nodes.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm/boot/dts/hip04.dtsi | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 2388145..267942a 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -269,6 +269,81 @@
 			interrupts = <0 372 4>;
 		};
 
+		gpio at 4003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4003000 0x1000>;
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
+
+		gpio at 4002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4002000 0x1000>;
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
+		gpio at 4001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4001000 0x1000>;
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
+		gpio at 4000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x4000000 0x1000>;
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
 	};
 
 	etb at 0,e3c42000 {
-- 
1.9.1
