From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Mar 2013 01:59:01 +0100
Subject: [PATCH 2/3] ARM: EXYNOS5250: dts: Add architected timer nodes
In-Reply-To: <1363222742-15220-1-git-send-email-agraf@suse.de>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
Message-ID: <1363222742-15220-3-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos 5250 SoC supports A15 style architected timers. Indicate
this through the device tree.

This is required by KVM.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm/boot/dts/exynos5250.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 768cb42..9fb4a38 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -57,6 +57,14 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	timer {
+                compatible = "arm,armv7-timer";
+                interrupts = <1 13 0xf08>,
+                             <1 14 0xf08>,
+                             <1 11 0xf08>,
+                             <1 10 0xf08>;
+        };
+
 	combiner:interrupt-controller at 10440000 {
 		compatible = "samsung,exynos4210-combiner";
 		#interrupt-cells = <2>;
-- 
1.7.10.4
