From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri, 13 Oct 2017 11:01:57 +0200
Subject: [PATCH v2 13/16] arm64: dts: marvell: armada-37xx: add UART clock
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Message-ID: <20171013090200.31034-14-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing clock property to armada-3700 UART node.

This clock will be used to derive the prescaler value to comply with
the requested baudrate.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index b554cdaf5e53..a36d667f770e 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -135,6 +135,7 @@
 			uart0: serial at 12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x200>;
+				clocks = <&xtalclk>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.11.0
