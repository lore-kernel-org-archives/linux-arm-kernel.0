From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 9 Jul 2014 16:14:18 +0300
Subject: [PATCH 1/3] ARM: dts: keystone: add mdio devices entries
In-Reply-To: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
References: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1404911660-10047-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 has MDIO HW block which are compatible
to Davinci SoCs:
See "Gigabit Ethernet (GbE) Switch Subsystem"
  See http://www.ti.com/lit/ug/sprugv9d/sprugv9d.pdf

Hence, add corresponding DT entry for Keystone 2.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c1414cb..89256fc 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -266,5 +266,16 @@
 			ranges = <0 0 0x30000000 0x10000000
 				  1 0 0x21000A00 0x00000100>;
 		};
+
+		mdio: mdio at 02090300 {
+			compatible	= "ti,keystone-mdio", "ti,davinci_mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg		= <0x02090300 0x100>;
+			status = "disabled";
+			clocks = <&clkpa>;
+			clock-names = "fck";
+			bus_freq	= <2500000>;
+		};
 	};
 };
-- 
1.7.9.5
