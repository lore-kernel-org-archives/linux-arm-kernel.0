From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 20:56:43 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: add rk3288 watchdog clock
In-Reply-To: <1736604.toH3biuFW2@phil>
References: <1736604.toH3biuFW2@phil>
Message-ID: <9945765.pgmzY3SFjQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock property for the watchdog on rk3288 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 910dcad..6fcf74b9 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -554,6 +554,7 @@
 	wdt: watchdog at ff800000 {
 		compatible = "rockchip,rk3288-wdt", "snps,dw-wdt";
 		reg = <0xff800000 0x100>;
+		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
-- 
2.1.1
