From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:11 +0200
Subject: [PATCH v2 08/17] ARM: dts: mvebu: armada-39x: enable the thermal
 sensor in Armada-39x SoCs
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-9-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The whole Armada 39x SoC family of processors has thermal sensor which can
be supported with existing driver.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 8a22c02..03dc0ec 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -413,6 +413,12 @@
 				clocks = <&mainpll>;
 				clock-output-names = "nand";
 			};
+
+			thermal at e8078 {
+				compatible = "marvell,armada380-thermal";
+				reg = <0xe4078 0x4>, <0xe4074 0x4>;
+				status = "okay";
+			};
 		};
 
 		pcie-controller {
-- 
1.8.3.1
