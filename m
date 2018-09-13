From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:45 -0500
Subject: [PATCH] arm64: dts: rockchip: Fix I2C bus unit-address error
Message-ID: <20180913181245.25484-21-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: Warning (i2c_bus_reg): /i2c at ff3d0000/codec at 0a: I2C bus unit address format error, expected "a"

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index e0d64f862322..2dceeea29b83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -131,7 +131,7 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
-	sgtl5000: codec at 0a {
+	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&sgtl5000_clk>;
-- 
2.17.1
