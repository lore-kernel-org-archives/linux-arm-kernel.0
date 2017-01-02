From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Jan 2017 17:37:06 +0100
Subject: [PATCH 06/22] ARM: dtsi: axp22x: add AXP22X ADC subnode
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Message-ID: <20170102163723.7939-7-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Powers AXP22X PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..a2c4401 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -52,6 +52,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp221_adc: axp221_adc {
+		compatible = "x-powers,axp221-adc";
+		#io-channel-cells = <1>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.9.3
