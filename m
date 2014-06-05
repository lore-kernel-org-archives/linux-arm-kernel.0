From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Thu,  5 Jun 2014 14:27:08 -0500
Subject: [PATCH 6/6] arm: pxa{27x,3xx}.dtsi: gpio cleanups
In-Reply-To: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
References: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
Message-ID: <425d904329d1ef92de5c475896682500ff66889c.1401995177.git.andrew.ruder@elecsyscorp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Define gpio0, gpio1 interrupts in pxa2xx since they are also used by
the pxa27x, pxa25x and pxa3xx.

* Remove several redundant tags from pxa3xx's gpio since they are the
same as the included pxa2xx.dtsi

* Correctly override the compatible tag in the pxa27x for the gpio
module.

Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
---
 arch/arm/boot/dts/pxa27x.dtsi | 3 +++
 arch/arm/boot/dts/pxa2xx.dtsi | 4 ++--
 arch/arm/boot/dts/pxa3xx.dtsi | 7 -------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 2d05aa9..26841d8 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -43,5 +43,8 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+		gpio: gpio at 40e00000 {
+			compatible = "intel,pxa27x-gpio";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index d233088..c21e80f 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -53,8 +53,8 @@
 			reg = <0x40e00000 0x10000>;
 			gpio-controller;
 			#gpio-cells = <0x2>;
-			interrupts = <10>;
-			interrupt-names = "gpio_mux";
+			interrupts = <8 9 10>;
+			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
 			ranges;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 83bb0ef..e689b99 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -31,13 +31,6 @@
 
 		gpio: gpio at 40e00000 {
 			compatible = "intel,pxa3xx-gpio";
-			reg = <0x40e00000 0x10000>;
-			interrupt-names = "gpio0", "gpio1", "gpio_mux";
-			interrupts = <8 9 10>;
-			gpio-controller;
-			#gpio-cells = <0x2>;
-			interrupt-controller;
-			#interrupt-cells = <0x2>;
 		};
 	};
 };
-- 
1.9.0.rc3.12.gbc97e2d
