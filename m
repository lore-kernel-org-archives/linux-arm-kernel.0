From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 18 Sep 2014 20:15:22 +0300
Subject: [PATCH 1/3] ARM: dts: keystone: add keystone irq controller node
In-Reply-To: <1411060524-25077-1-git-send-email-grygorii.strashko@ti.com>
References: <1411060524-25077-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1411060524-25077-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone IRQ controller IP node which allows ARM
CorePac core to receive signals from DSP cores.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 9e31fe7..1820d9e 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -277,5 +277,13 @@
 			clock-names = "fck";
 			bus_freq	= <2500000>;
 		};
+
+		kirq0: keystone_irq at 26202a0 {
+			compatible = "ti,keystone-irq";
+			interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			ti,syscon-dev = <&devctrl 0x2a0>;
+		};
 	};
 };
-- 
1.9.1
