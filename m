From: jon.mason@broadcom.com (Jon Mason)
Date: Thu,  2 Mar 2017 19:21:32 -0500
Subject: [PATCH v2 1/3] ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags
In-Reply-To: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
References: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1488500494-20622-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GIC_PPI flags were misconfigured for the timers, resulting in errors
like:
[    0.000000] GIC: PPI11 is secure or misconfigured

Changing them to being edge triggered corrects the issue

Suggested-by: Rafa? Mi?ecki <rafal@milecki.pl>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: d27509f1 ("ARM: BCM5301X: add dts files for BCM4708 SoC")
---
 arch/arm/boot/dts/bcm5301x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4fbb089..00de62d 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -66,14 +66,14 @@
 		timer at 20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
 		local-timer at 20600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x20600 0x100>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.7.4
