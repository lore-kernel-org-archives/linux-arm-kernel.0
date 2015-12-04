From: yrdreddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 4 Dec 2015 12:12:42 -0500
Subject: [PATCH v2 3/3] ARM: dts: enable GPIO-a for Broadcom NSP
Message-ID: <1449249162-16850-1-git-send-email-yrdreddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the GPIO-a support for Broadcom NSP SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 58aca27..148d79e 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -116,4 +116,16 @@
 			status = "disabled";
 		};
 	};
+
+	gpioa: gpio at 18000020 {
+		compatible = "brcm,nsp-gpio-a";
+		reg = <0x18000020 0x70>,
+		      <0x1803f1c4 0x1c>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		ngpios = <32>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-ranges = <&pinctrl 0 0 32>;
+	};
 };
-- 
2.1.0
