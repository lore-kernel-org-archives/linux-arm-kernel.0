From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 26 Aug 2016 18:48:01 +0800
Subject: [PATCH v2] arm64: dts: rockchip: fix the address map for WDT0 and WDT1
Message-ID: <1472208482-30862-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To rename "watchdog" to "watchdog0" explicitly for looking up.
Dues to incorrect description in the TRM, the WDTs base address
should be fixed and swap them like this:
WDT0 - 0xff848000
WDT1 - 0xff840000

And, it is right that only WDT0 can generate global software reset.
We will update the TRM to fix it.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- rename node name "watchdog" to "watchdog0" explicitly

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index bc86e8c..1e714a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1002,9 +1002,9 @@
 		};
 	};
 
-	watchdog at ff840000 {
+	watchdog0 at ff848000 {
 		compatible = "snps,dw-wdt";
-		reg = <0x0 0xff840000 0x0 0x100>;
+		reg = <0x0 0xff848000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
1.7.9.5
