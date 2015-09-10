From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 15:22:30 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add the auxiliary clocks to the device tree.
In-Reply-To: <1441923750-19404-1-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
Message-ID: <1441923750-19404-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These will be used for enabling UART1, SPI1, and SPI2.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a6a55b7..7c37956 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -73,6 +73,13 @@
 			clocks = <&clk_osc>;
 		};
 
+		aux_clocks: aux-clocks at 0x7e215004 {
+			compatible = "brcm,bcm2835-aux-clock";
+			#clock-cells = <1>;
+			reg = <0x7e215004 0x4>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+		};
+
 		rng at 7e104000 {
 			compatible = "brcm,bcm2835-rng";
 			reg = <0x7e104000 0x10>;
-- 
2.1.4
