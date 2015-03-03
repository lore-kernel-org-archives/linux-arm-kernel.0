From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  3 Mar 2015 11:43:18 +0100
Subject: [PATCH v2 5/7] ARM: mvebu: Enable Performance Monitor Unit on Armada
 375 SoC
In-Reply-To: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425379400-4346-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The Armada 375 SoC has a Cortex-A9 CPU, and so the PMU is available
to be used. This commit enables it in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index ba3c57e0af72..6c8fb3bcd6ef 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -96,6 +96,11 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts-extended = <&mpic 3>;
+	};
+
 	soc {
 		compatible = "marvell,armada375-mbus", "simple-bus";
 		#address-cells = <2>;
-- 
2.3.0
