From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 29 Jan 2016 16:49:21 +0800
Subject: [RFC PATCH] ARM: dts: rockchip: increase the mclk_fs to 512 for kylin
 board
Message-ID: <1454057361-22923-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we playback the 8KHz FS audio with the 256 mclk_fs, we need the
mclk = 256 * 8000 = 2.048MHz, the frac div is 594 / 2.048 = 290,
the frac div value 0x00809015 set to the CRU_CLKSEL7_CON will cause
to hang.

We increase the mclk_fs to 512, will get the mclk = 512 * 8000 =
4.096MHz, use 0x01009015 instead of 0x00809015 to work around this
issue. We will keep tracking it.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 arch/arm/boot/dts/rk3036-kylin.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 190f22c..be468f9 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -67,7 +67,7 @@
 		compatible = "simple-audio-card";
 		simple-audio-card,format = "i2s";
 		simple-audio-card,name = "rockchip,rt5616-codec";
-		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,mclk-fs = <512>;
 		simple-audio-card,widgets =
 			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack";
-- 
1.7.9.5
