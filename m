From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed,  4 Nov 2015 20:25:41 +0800
Subject: [PATCH v6 7/8] ARM: dts: enable smp for rk3036
In-Reply-To: <1446639503-11763-1-git-send-email-zhengxing@rock-chips.com>
References: <1446639503-11763-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1446639941-11993-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable smp for rk3036, and add the smp sram name for adapting.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v6: None

 arch/arm/boot/dts/rk3036.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 380fe10..61b40dd 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -75,6 +75,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "rockchip,rk3036-smp";
 
 		cpu0: cpu at f00 {
 			device_type = "cpu";
@@ -157,6 +158,10 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x10080000 0x2000>;
+		smp-sram at 0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x00 0x10>;
+		};
 	};
 
 	cru: clock-controller at 20000000 {
-- 
1.7.9.5
