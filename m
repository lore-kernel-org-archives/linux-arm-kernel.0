From: daniel@zonque.org (Daniel Mack)
Date: Mon,  5 Nov 2018 20:18:27 +0100
Subject: [PATCH] ARM: dts: pxa3xx: add gcu node
Message-ID: <20181105191827.3860-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for hardware graphic acceleration.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 3a8f0edc3af9..264f681bebd9 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -300,4 +300,12 @@
 		clocks = <&clks CLK_OSTIMER>;
 		status = "okay";
 	};
+
+	gcu: display-controller at 54000000 {
+		compatible = "marvell,pxa300-gcu";
+		reg = <0x54000000 0x1000>;
+		interrupts = <39>;
+		clocks = <&clks CLK_PXA300_GCU>;
+		status = "disabled";
+	};
 };
-- 
2.17.2
