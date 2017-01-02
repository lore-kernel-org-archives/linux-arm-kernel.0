From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Jan 2017 17:37:20 +0100
Subject: [PATCH 20/22] ARM: dtsi: axp22x: add battery power supply subnode
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Message-ID: <20170102163723.7939-21-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP22X PMIC exposes battery supply various data such as
the battery status (charging, discharging, full, dead), current max
limit, current current, battery capacity (in percentage), voltage max
limit, current voltage, and battery capacity (in Ah).

This adds the battery power supply subnode for AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index aba7fde..c4a64a5 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -62,6 +62,13 @@
 		#io-channel-cells = <1>;
 	};
 
+	battery_power_supply: battery_power_supply {
+		compatible = "x-powers,axp221-battery-power-supply";
+		io-channels = <&axp221_adc 1>, <&axp221_adc 2>, <&axp221_adc 3>;
+		io-channel-names = "batt_v", "batt_chrg_i", "batt_dischrg_i";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.9.3
