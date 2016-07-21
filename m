From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 14:44:06 +0200
Subject: [PATCH 09/18] ARM: mvebu: a39x: enable the thermal sensor in
 Armada-39x SoCs
In-Reply-To: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
Message-ID: <1469105055-25181-11-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
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
