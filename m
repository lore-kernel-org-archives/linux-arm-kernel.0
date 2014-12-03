From: stefan@agner.ch (Stefan Agner)
Date: Wed,  3 Dec 2014 01:12:00 +0100
Subject: [PATCH 01/12] ARM: dts: vf610: add routable-irqs property for gic node
In-Reply-To: <1417565531-4507-1-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
Message-ID: <1417565531-4507-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan.agner@toradex.com>

To enable proper routable interrupt controller support for
the GIC driver, the routable-irqs need to be specified.
Hence add the routable-irqs property with the amount of
IRQs supported by the GIC controller on the Vybrid SoC.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index de67005..2b0d84d 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -30,6 +30,7 @@
 
 			intc: interrupt-controller at 40002000 {
 				compatible = "arm,cortex-a9-gic";
+				arm,routable-irqs = <144>;
 				#interrupt-cells = <3>;
 				interrupt-controller;
 				reg = <0x40003000 0x1000>,
-- 
2.1.3
