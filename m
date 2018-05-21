From: christophe.roullier@st.com (Christophe Roullier)
Date: Mon, 21 May 2018 10:07:25 +0200
Subject: [PATCH V3 7/8] ARM: dts: stm32: add support of ethernet on
 stm32mp157c-ev1
In-Reply-To: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
References: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1526890046-10565-8-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAC is connected to a PHY in RGMII mode.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..a7fee5c 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -17,5 +17,25 @@
 
 	aliases {
 		serial0 = &uart4;
+		ethernet0 = &ethernet0;
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rgmii";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy at 0 {
+			reg = <0>;
+		};
 	};
 };
-- 
1.9.1
