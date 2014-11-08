From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Sat,  8 Nov 2014 01:44:56 +0100
Subject: [PATCH] ARM: dts: rockchip: fix invalid unit-address in rk3188.dtsi
In-Reply-To: <5384745.1WqprI8GVl@diego>
References: <5384745.1WqprI8GVl@diego>
Message-ID: <1415407496-18507-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unit addresses, whilst written in hex, don't contain a 0x prefix.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3188.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index b24e04f..1d4d79c 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -111,7 +111,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		gpio0: gpio0 at 0x2000a000 {
+		gpio0: gpio0 at 2000a000 {
 			compatible = "rockchip,rk3188-gpio-bank0";
 			reg = <0x2000a000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
@@ -124,7 +124,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		gpio1: gpio1 at 0x2003c000 {
+		gpio1: gpio1 at 2003c000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.0
