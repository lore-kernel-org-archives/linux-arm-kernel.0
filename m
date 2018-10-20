From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 20 Oct 2018 10:57:56 -0700
Subject: [PATCH] arm64: dts: rockchip: enable HS200 for eMMC on rock64
Message-ID: <20181020175756.28072-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

eMMC that's sold by Pine64 can do HS200, rk3328 can do it
as well, so update DTS to enable it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index dc20145dd393..bd937d68ca3b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -100,6 +100,7 @@
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-- 
2.19.0
