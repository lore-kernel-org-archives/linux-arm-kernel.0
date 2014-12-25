From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 25 Dec 2014 14:12:22 +0800
Subject: [PATCH 2/2] ARM: dts: berlin: add PPI cpu mask to twd timer interrupts
In-Reply-To: <1419487942-2277-1-git-send-email-jszhang@marvell.com>
References: <1419487942-2277-1-git-send-email-jszhang@marvell.com>
Message-ID: <1419487942-2277-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 3 ++-
 arch/arm/boot/dts/berlin2cd.dtsi | 3 ++-
 arch/arm/boot/dts/berlin2q.dtsi  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 015a06c..f6d9002 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -104,7 +104,8 @@
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&chip CLKID_TWD>;
 		};
 
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index a318bc3..517a364 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -76,7 +76,8 @@
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&chip CLKID_TWD>;
 		};
 
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 933dcbb..33fbf8f 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -112,7 +112,8 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			clocks = <&chip CLKID_TWD>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		gic: interrupt-controller at ad1000 {
-- 
2.1.4
