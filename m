From: ryan@edited.us (Ryan Grachek)
Date: Fri, 30 Mar 2018 11:11:18 -0500
Subject: [PATCH] arm64: dts: hikey: Enable SDIO high-speed mode on WL1835
 module
Message-ID: <20180330161118.5751-1-ryan@edited.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to hardware documentation, the WL1835MOD WiFi chip
supports SDIO high-speed mode, which increases the clock to
50 MHz. This results in a modest increase in throughput.

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 5d5aa4f4a235..a5e0cc4370e1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -322,6 +322,7 @@
 
 		dwmmc_2: dwmmc2 at f723f000 {
 			bus-width = <0x4>;
+			cap-sd-highspeed;
 			non-removable;
 			vmmc-supply = <&reg_vdd_3v3>;
 			mmc-pwrseq = <&wl1835_pwrseq>;
-- 
2.11.0
