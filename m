From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 10:28:34 +0100
Subject: [PATCH v2 1/1] ARM: DT: STi: STiH416: Add DT node for ST's SATA device
In-Reply-To: <1405931573-12407-1-git-send-email-lee.jones@linaro.org>
References: <1405931573-12407-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140722092834.GA8406@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: DT: STi: STiH416: Add DT node for ST's SATA device
    
Cc: devicetree at vger.kernel.org
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

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
