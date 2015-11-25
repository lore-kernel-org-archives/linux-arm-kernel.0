From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:39 +0200
Subject: [PATCH 07/18] ARM: am57xx: cl-som-am57x: dts: add dual EMAC support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-8-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dual EMAC support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 105 ++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index cf2328d..a838ea4 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -104,6 +104,85 @@
 			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs3.qspi1_cs1 */
 		>;
 	};
+
+	cpsw_pins_default: cpsw_pins_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
+			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
+			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
+			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
+			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
+			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
+
+			/* Slave 2 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
+			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
+		>;
+	};
+
+	cpsw_pins_sleep: cpsw_pins_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3654, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3658, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x365c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3660, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3664, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE15)
+
+			/* Slave 2 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x359c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE15)
+		>;
+	};
+
+	davinci_mdio_pins_default: davinci_mdio_pins_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			DRA7XX_CORE_IOPAD(0x363c, PIN_OUTPUT_PULLUP | MUX_MODE0)/* mdio_mclk */
+			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
+		>;
+	};
+
+	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x363c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT | MUX_MODE15)
+		>;
+	};
 };
 
 &i2c1 {
@@ -372,3 +451,29 @@
 		};
 	};
 };
+
+&mac {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_pins_default>;
+	pinctrl-1 = <&cpsw_pins_sleep>;
+	dual_emac;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <2>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <2>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_pins_default>;
+	pinctrl-1 = <&davinci_mdio_pins_sleep>;
+};
-- 
1.9.1
