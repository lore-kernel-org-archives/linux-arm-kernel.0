From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 24 Aug 2016 22:22:22 +0300
Subject: [PATCH v2] ARM: dts: blanche: add support for general purpose LEDs
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <2604564.o6QQK9elnf@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the general purpose LEDs on the Blanche board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160824-v4.8-rc3' of Simon Horman's
'renesas.git'.

Changes in version 2:
- removed the "label" props.

 arch/arm/boot/dts/r8a7792-blanche.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -159,6 +159,23 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led17 {
+			gpios = <&gpio10 10 GPIO_ACTIVE_HIGH>;
+		};
+		led18 {
+			gpios = <&gpio10 11 GPIO_ACTIVE_HIGH>;
+		};
+		led19 {
+			gpios = <&gpio10 12 GPIO_ACTIVE_HIGH>;
+		};
+		led20 {
+			gpios = <&gpio10 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
