From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 10:43:46 -0300
Subject: [PATCH 6/7] ARM: mvebu: Enable Performance Monitor Unit on Armada
 380/385 SoC
In-Reply-To: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1413985427-20918-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 380 and 385 SoCs have a Cortex-A9 CPU, so the PMU is available
to be used. This commit enables it in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 242d0ec..bba3c90 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -30,6 +30,11 @@
 		eth2 = &eth2;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts-extended = <&mpic 3>;
+	};
+
 	soc {
 		compatible = "marvell,armada380-mbus", "marvell,armada370-mbus",
 			     "simple-bus";
-- 
2.1.0
