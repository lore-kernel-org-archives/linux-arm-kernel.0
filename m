From: eric@anholt.net (Eric Anholt)
Date: Mon, 20 Jul 2015 12:33:03 -0700
Subject: [PATCH v4 4/8] ARM: bcm2835: Drop never-used clock-frequency property
 of uart0.
In-Reply-To: <1437420787-32137-1-git-send-email-eric@anholt.net>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
Message-ID: <1437420787-32137-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to have been copy-and-paste from another serial driver's
DT.  The driver has never used this value -- instead, the pl011 driver
is getting the fixed 20201000.uart clock from clk-bcm2835.c.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..32f5830 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -96,7 +96,6 @@
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-			clock-frequency = <3000000>;
 			arm,primecell-periphid = <0x00241011>;
 		};
 
-- 
2.1.4
