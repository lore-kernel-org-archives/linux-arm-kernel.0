From: eric@anholt.net (Eric Anholt)
Date: Fri, 26 Feb 2016 15:05:41 -0800
Subject: [PATCH 3/4] ARM: bcm2835: Include SDHOST in the device tree.
In-Reply-To: <1456527942-3045-1-git-send-email-eric@anholt.net>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
Message-ID: <1456527942-3045-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's disabled by default, and will be enabled by a particular board's
DT.  The DMA channels are also currently left out, because our DMA
engine support doesn't yet include slave SG, and there doesn't appear
to be a clean way to include "does slave SG" in the channel
request/config process.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 597a78f..7b2721b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -366,6 +366,14 @@
 			status = "disabled";
 		};
 
+		sdhost: sdhost at 7e202000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7e202000 0x100>;
+			interrupts = <2 24>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+			status = "disabled";
+		};
+
 		pwm: pwm at 7e20c000 {
 			compatible = "brcm,bcm2835-pwm";
 			reg = <0x7e20c000 0x28>;
-- 
2.7.0
