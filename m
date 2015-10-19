From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:10 +0530
Subject: [PATCH 03/11] dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASIU gpio controller's pins are muxed with pin-cntroller.
Add this mapping through property "gpio-ranges".

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e1ac07a..6621f13 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -84,10 +84,59 @@
 		#gpio-cells = <2>;
 		gpio-controller;
 
-		pinmux = <&pinctrl>;
-
 		interrupt-controller;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-ranges = <&pinctrl 0 42 1>,
+				<&pinctrl 1 44 3>,
+				<&pinctrl 4 48 1>,
+				<&pinctrl 5 50 3>,
+				<&pinctrl 8 126 1>,
+				<&pinctrl 9 155 1>,
+				<&pinctrl 10 152 1>,
+				<&pinctrl 11 154 1>,
+				<&pinctrl 12 153 1>,
+				<&pinctrl 13 127 3>,
+				<&pinctrl 16 140 1>,
+				<&pinctrl 17 145 7>,
+				<&pinctrl 24 130 10>,
+				<&pinctrl 34 141 4>,
+				<&pinctrl 38 54 1>,
+				<&pinctrl 39 56 3>,
+				<&pinctrl 42 60 3>,
+				<&pinctrl 45 64 3>,
+				<&pinctrl 48 68 2>,
+				<&pinctrl 50 84 6>,
+				<&pinctrl 56 94 6>,
+				<&pinctrl 62 72 1>,
+				<&pinctrl 63 70 1>,
+				<&pinctrl 64 80 1>,
+				<&pinctrl 65 74 3>,
+				<&pinctrl 68 78 1>,
+				<&pinctrl 69 82 1>,
+				<&pinctrl 70 156 17>,
+				<&pinctrl 87 104 12>,
+				<&pinctrl 99 102 2>,
+				<&pinctrl 101 90 4>,
+				<&pinctrl 105 116 6>,
+				<&pinctrl 111 100 2>,
+				<&pinctrl 113 122 4>,
+				<&pinctrl 123 11 1>,
+				<&pinctrl 124 38 4>,
+				<&pinctrl 128 43 1>,
+				<&pinctrl 129 47 1>,
+				<&pinctrl 130 49 1>,
+				<&pinctrl 131 53 1>,
+				<&pinctrl 132 55 1>,
+				<&pinctrl 133 59 1>,
+				<&pinctrl 134 63 1>,
+				<&pinctrl 135 67 1>,
+				<&pinctrl 136 71 1>,
+				<&pinctrl 137 73 1>,
+				<&pinctrl 138 77 1>,
+				<&pinctrl 139 79 1>,
+				<&pinctrl 140 81 1>,
+				<&pinctrl 141 83 1>,
+				<&pinctrl 142 10 1>;
 	};
 
 	amba {
-- 
1.9.1
