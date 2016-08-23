From: lars.persson@axis.com (Lars Persson)
Date: Tue, 23 Aug 2016 16:00:52 +0200
Subject: [PATCH 3/3] ARM: dts: artpec: set irq affinity on pmu interrupts
In-Reply-To: <cover.1471959733.git.larper@axis.com>
References: <cover.1471959733.git.larper@axis.com>
Message-ID: <48257590bc198f5b469d041a41c334ef2eb873cc.1471959733.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq affinity is required for pmu interrupts.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 4e40d55..3489019c 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -150,6 +150,7 @@
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
 		interrupt-parent = <&intc>;
 	};
 
-- 
2.1.4
