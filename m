From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 14 Feb 2017 10:41:02 +0100
Subject: [PATCH v3 08/18] ARM: dtsi: axp22x: add AC power supply subnode
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Message-ID: <20170214094112.27426-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP22X PMIC exposes the status of AC power supply.

This adds the AC power supply subnode for the AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

v2:
 - changed DT node name from ac_power_supply to ac-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),

 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..67331c5 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -52,6 +52,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp221-ac-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.9.3
