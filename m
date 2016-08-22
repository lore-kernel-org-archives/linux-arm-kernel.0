From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Aug 2016 23:39:30 +0300
Subject: [PATCH] ARM: dts: blanche: add support for general purpose LEDs
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <1529754.UBcqZ7GKj7@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the general purpose LEDs on the Blanche board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160822-v4.8-rc3' of Simon Horman's
'renesas.git' repo plus the SDHI0/DU patches posted earlier.

 arch/arm/boot/dts/r8a7792-blanche.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -159,6 +159,27 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led17 {
+			gpios = <&gpio10 10 GPIO_ACTIVE_HIGH>;
+			label = "LED17";
+		};
+		led18 {
+			gpios = <&gpio10 11 GPIO_ACTIVE_HIGH>;
+			label = "LED18";
+		};
+		led19 {
+			gpios = <&gpio10 12 GPIO_ACTIVE_HIGH>;
+			label = "LED19";
+		};
+		led20 {
+			gpios = <&gpio10 23 GPIO_ACTIVE_HIGH>;
+			label = "LED20";
+		};
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
