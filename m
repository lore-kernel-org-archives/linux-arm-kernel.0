From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Jun 2015 16:31:14 +0200
Subject: [PATCH] ARM: dts: rockchip: fix rk3288 watchdog irq
Message-ID: <1961157.dsytR1KvKa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog irq is actually SPI 79, which translates to the original
111 in the manual where the SPI irqs start at 32.
The current dw_wdt driver does not use the irq at all, so this issue
never surfaced. Nevertheless fix this for a time we want to use the irq.

Fixes: 2ab557b72d46 ("ARM: dts: rockchip: add core rk3288 dtsi")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Found while verifying the data for the quite similar rk3368 arm64 soc.

 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 22316d0..858efd0 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -626,7 +626,7 @@
 		compatible = "rockchip,rk3288-wdt", "snps,dw-wdt";
 		reg = <0xff800000 0x100>;
 		clocks = <&cru PCLK_WDT>;
-		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-- 
2.1.4
