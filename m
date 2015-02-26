From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:13:12 +0100
Subject: [PATCH 7/8] ARM: mvebu: Enable Performance Monitor Unit on Armada
 380/385 SoC
In-Reply-To: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424945593-20320-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The Armada 380 and 385 SoCs have a Cortex-A9 CPU, so the PMU is available
to be used. This commit enables it in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 885fcee6580c..7cd95801d844 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -64,6 +64,11 @@
 		ethernet2 = &eth2;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts-extended = <&mpic 3>;
+	};
+
 	soc {
 		compatible = "marvell,armada380-mbus", "simple-bus";
 		#address-cells = <2>;
-- 
2.3.0
