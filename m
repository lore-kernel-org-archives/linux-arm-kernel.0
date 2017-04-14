From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Apr 2017 22:51:11 +0200
Subject: [PATCH 1/2] arm: spear6xx: add DT description of the ADC on SPEAr600
In-Reply-To: <1492203072-27771-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1492203072-27771-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1492203072-27771-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPEAr600 has a built-in ADC, which already has a Device Tree binding
described in
Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt. This
commit adds the description in the SPEAr600 Device Tree of this ADC
device.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/spear600.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 8459286..6b32d20 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -204,6 +204,14 @@
 				interrupt-parent = <&vic0>;
 				interrupts = <16>;
 			};
+
+			adc: adc at d820b000 {
+				compatible = "st,spear600-adc";
+				reg = <0xd820b000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <6>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.7.4
