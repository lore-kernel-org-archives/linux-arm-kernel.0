From: maj@jamers.net (Mark James)
Date: Tue, 17 Mar 2015 21:35:23 +0000
Subject: ARM: socfpga: dts: fix spi1 interrupt
Message-ID: <55089E1B.7000600@jamers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The socfpga.dtsi currently has the wrong interrupt number set for SPI master 1. Trying to use the master without this change results in the kernel boot process waiting forever for an interrupt that will never occur while attempting to probe any slave devices configured in the device tree as being under SPI master 1.

The change works for the Cyclone V, and according to the Arria 5 handbook should be good there too.


Signed-off-by: Mark James <maj@jamers.net>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9d87609..d9176e6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -660,7 +660,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfff01000 0x1000>;
-			interrupts = <0 156 4>;
+			interrupts = <0 155 4>;
 			num-cs = <4>;
 			clocks = <&spi_m_clk>;
 			status = "disabled";
-- 
2.1.0
