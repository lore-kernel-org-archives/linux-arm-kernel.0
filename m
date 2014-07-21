From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jul 2014 09:32:53 +0100
Subject: [RESEND PATCH 1/1] ARM: DT: STi: STiH416: Add DT node for ST's SATA
 device
Message-ID: <1405931573-12407-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/ata/ahci-st.txt |  2 +-
 arch/arm/boot/dts/stih416-b2020.dts               |  4 ++++
 arch/arm/boot/dts/stih416-b2020e.dts              |  4 ++++
 arch/arm/boot/dts/stih416.dtsi                    | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
index 0574a77..9883542 100644
--- a/Documentation/devicetree/bindings/ata/ahci-st.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
@@ -21,7 +21,7 @@ Example:
 		reg             = <0xfe380000 0x1000>;
 		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
 		interrupt-names = "hostc";
-		phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
+		phys	        = <&phy_port0 MIPHY_TYPE_SATA>;
 		phy-names       = "ahci_phy";
 		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
 				  <&softreset STIH416_SATA0_SOFTRESET>;
diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index c3c2ac6..eb2f246 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -23,5 +23,9 @@
 				st,pcie-tx-pol-inv;
 			};
 		};
+
+		sata0: sata at fe380000{
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416-b2020e.dts b/arch/arm/boot/dts/stih416-b2020e.dts
index 80aff0f..99a699e 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -41,5 +41,9 @@
 				st,pcie-tx-pol-inv;
 			};
 		};
+
+		sata0: sata at fe380000{
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 2b98a0a..060dd53 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -258,5 +258,21 @@
 				reg-names = "sata", "pcie", "syscfg";
 			};
 		};
+
+		sata0: sata at fe380000 {
+			compatible      = "st,sti-ahci";
+			reg             = <0xfe380000 0x1000>;
+			interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
+			interrupt-names = "hostc";
+			phys	        = <&phy_port0 MIPHY_TYPE_SATA>;
+			phy-names       = "sata-phy";
+			resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
+					  <&softreset STIH416_SATA0_SOFTRESET>;
+			reset-names     = "pwr-dwn", "sw-rst";
+			clock-names     = "ahci_clk";
+			clocks	        = <&clk_s_a0_ls CLK_ICN_REG>;
+
+			status	        = "disabled";
+		};
 	};
 };
-- 
1.8.3.2
