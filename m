From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  9 Dec 2017 12:26:35 +0100
Subject: [PATCH V3 2/2] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
References: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1512818795-1441-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
the bcm2835-i2s requires a clock as DT property. Unfortunately
the necessary DT change has never been applied. While we are at it
also fix the first PCM register range to cover the PCM_GRAY register.

Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Matthias Reichl <hias@horus.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 013431e..e08203c 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -396,8 +396,8 @@
 
 		i2s: i2s at 7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 			dmas = <&dma 2>,
 			       <&dma 3>;
-- 
2.7.4
