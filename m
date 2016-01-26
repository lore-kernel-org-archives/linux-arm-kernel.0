From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 26 Jan 2016 10:06:59 +0800
Subject: [PATCH] arm64: dts: rockchip: remove broken-cd from emmc and sdio
Message-ID: <1453774019-10225-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only one of "broken-cd" and "non-removable" should be supplied
according to Documentation/devicetree/bindings/mmc/mmc.txt.
Obviously emmc and sdio-wifi are non-removable devices, while
broken-cd is for removable device whose card detect pin is broken.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 8c219cc..19616a4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -152,7 +152,6 @@
 };
 
 &emmc {
-	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 104cbee..047c8f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -185,7 +185,6 @@
 };
 
 &emmc {
-	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	disable-wp;
-- 
2.3.7
