From: oleksandr.kozaruk@ti.com (Oleksandr Kozaruk)
Date: Wed, 10 Jul 2013 10:08:53 +0300
Subject: [PATCH v2 1/2] ARM: dts: twl: Add GPADC data to device tree
In-Reply-To: <1373440134-30118-1-git-send-email-oleksandr.kozaruk@ti.com>
References: <1373440134-30118-1-git-send-email-oleksandr.kozaruk@ti.com>
Message-ID: <1373440134-30118-2-git-send-email-oleksandr.kozaruk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..434842c 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	gpadc: twl6030_gpadc {
+		compatible = "ti,twl6030_gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.7.9.5
