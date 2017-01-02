From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Jan 2017 17:37:11 +0100
Subject: [PATCH 11/22] ARM: dtsi: axp22x: add AC power supply subnode
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Message-ID: <20170102163723.7939-12-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP22X PMIC exposes the status of AC power supply.

This adds the AC power supply subnode for the AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index a2c4401..aba7fde 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -52,6 +52,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac_power_supply {
+		compatible = "x-powers,axp221-ac-power-supply";
+		status = "disabled";
+	};
+
 	axp221_adc: axp221_adc {
 		compatible = "x-powers,axp221-adc";
 		#io-channel-cells = <1>;
-- 
2.9.3
