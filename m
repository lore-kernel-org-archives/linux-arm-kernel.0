From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:31 +0200
Subject: [PATCH 22/32] ARM: bcm2835: Include SDHOST in the device tree.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-23-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

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
index 3866fc7a..170d620 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -399,6 +399,14 @@
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
1.8.3.1
