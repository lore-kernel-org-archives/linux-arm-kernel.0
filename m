From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 26 Aug 2016 14:22:30 +0800
Subject: [PATCH] arm64: dts: rockchip: fix the address map for WDT0 and WDT1
Message-ID: <1472192551-16754-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dues to incorrect description in the TRM, the WDTs base address
should be fixed and swap them like this:
WDT0 - 0xff848000
WDT1 - 0xff840000

And, it is right that only WDT0 can generate global software reset.
We will update the TRM to fix it.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index bc86e8c..f0f52c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1002,9 +1002,9 @@
 		};
 	};
 
-	watchdog at ff840000 {
+	watchdog at ff848000 {
 		compatible = "snps,dw-wdt";
-		reg = <0x0 0xff840000 0x0 0x100>;
+		reg = <0x0 0xff848000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
1.9.1
