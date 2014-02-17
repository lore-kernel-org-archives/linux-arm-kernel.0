From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Feb 2014 12:56:57 +0000
Subject: [PATCH 2/3] ARM: DT: STi: Add DT node for ST's SATA device
In-Reply-To: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1392641818-23419-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2020-revE.dts |  4 ++++
 arch/arm/boot/dts/stih416-b2020.dts      |  4 ++++
 arch/arm/boot/dts/stih416.dtsi           | 16 ++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
index 693d0ec..7350a86 100644
--- a/arch/arm/boot/dts/stih416-b2020-revE.dts
+++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
@@ -37,5 +37,9 @@
 			st,pcie-tx-pol-inv;
 			st,sata-gen = <3>;
 		};
+
+		sata0: sata at fe380000{
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index fd9cbad..ebd784b 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -18,5 +18,9 @@
 			st,pcie_tx_pol_inv = <1>;
 			st,sata_gen = "gen3";
 		};
+
+		sata0: sata at fe380000{
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 9fd8efb..d1c874f 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -153,5 +153,21 @@
 			#phy-cells 	= <2>;
 			st,syscfg  	= <&syscfg_rear>;
 		};
+
+		sata0: sata at fe380000 {
+			compatible      = "st,ahci";
+			reg             = <0xfe380000 0x1000>;
+			interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
+			interrupt-names = "hostc";
+			phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
+			phy-names       = "ahci_phy";
+			resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
+					  <&softreset STIH416_SATA0_SOFTRESET>;
+			reset-names     = "pwr-dwn", "sw-rst";
+			clock-names     = "ahci_clk";
+			clocks	        = <&CLK_S_ICN_REG_0>;
+
+			status	        = "disabled";
+		};
 	};
 };
-- 
1.8.3.2
