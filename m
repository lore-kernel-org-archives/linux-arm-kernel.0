From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun,  4 Sep 2016 16:34:27 +0800
Subject: [PATCH 2/4] ARM: dts: rockchip: fix i2c address L3G4200D on
 PopMetal-RK3288 board
In-Reply-To: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
References: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1472978067-868-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c address of the three-axis digital gyroscope L3G4200D should be
0x69 according to hardware design.
Also add power supply reference for L3G3200D and the 3-axis Electronic
Compass AK8963.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rk3288-popmetal.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 802216f..706c67c 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -391,12 +391,16 @@
 		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&comp_int>;
+		vdd-supply = <&vcc_io>;
+		vid-supply = <&vcc_io>;
 	};
 
-	l3g4200d: l3g4200d at 68 {
+	l3g4200d: l3g4200d at 69 {
 		compatible = "st,l3g4200d-gyro";
 		st,drdy-int-pin = <2>;
-		reg = <0x6b>;
+		reg = <0x69>;
+		vdd-supply = <&vcc_io>;
+		vddio-supply = <&vcc_io>;
 	};
 
 	mma8452: mma8452 at 1d {
-- 
2.7.4
