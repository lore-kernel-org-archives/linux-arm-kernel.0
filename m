From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 07 Nov 2015 23:44:05 +0100
Subject: [PATCH v2] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
In-Reply-To: <1446806797-20912-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1446806797-20912-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <2126321.1P94dtJ1Xt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 6. November 2015, 11:46:37 schrieb Sjoerd Simons:
> Add an ethernet0 alias for the RK3288 mac interface so
> that u-boot can find the device-node and fill in the mac address on
> board that support a wired network interface.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

applied to me dts32 branch for 4.5

while at it, I also added the alias for other supported Rockchip Socs
the CortexA9 ones and the rk3368, like below:

------------ 8< --------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 7 Nov 2015 22:37:26 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup rk3066/rk3188 ethernet0 alias for
 u-boot

Add an ethernet0 alias for the RK3066/RK3188 mac interface so
that u-boot can find the device-node and fill in the mac address on
boards that support a wired network interface.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..99eeea7 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -49,6 +49,7 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		ethernet0 = &emac;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.6.2

------------ 8< --------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 7 Nov 2015 22:39:26 +0100
Subject: [PATCH] arm64: dts: rockchip: Setup rk3368 ethernet0 alias for u-boot

Add an ethernet0 alias for the RK3368 mac interface so
that u-boot can find the device-node and fill in the mac address on
boards that support a wired network interface.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cc093a4..1f10b85 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -53,6 +53,7 @@
 	#size-cells = <2>;
 
 	aliases {
+		ethernet0 = &gmac;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.6.2

------------ 8< --------------
