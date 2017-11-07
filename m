From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  7 Nov 2017 14:28:12 -0800
Subject: [PATCH 2/2] ARM: dts: NSP: Fix PPI interrupt types
In-Reply-To: <20171107222812.17267-1-f.fainelli@gmail.com>
References: <20171107222812.17267-1-f.fainelli@gmail.com>
Message-ID: <20171107222812.17267-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting a kernel results in the kernel warning us about the following
PPI interrupts configuration:
[    0.105127] smp: Bringing up secondary CPUs ...
[    0.110545] GIC: PPI11 is secure or misconfigured
[    0.110551] GIC: PPI13 is secure or misconfigured

Fix this by using the appropriate edge configuration for PPI11 and
PPI13, this is similar to what was fixed for Northstar (BCM5301X) in
commit 0e34079cd1f6 ("ARM: dts: BCM5301X: Correct GIC_PPI interrupt
flags").

Fixes: 1a9d53cabaf4 ("ARM: dts: NSP: Add TWD Support to DT")
Fixes: 1a9d53cabaf4 ("ARM: dts: NSP: Add TWD Support to DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index dff66974feed..d5f5e92e7488 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -85,7 +85,7 @@
 		timer at 20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
@@ -93,7 +93,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x20600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.9.3
