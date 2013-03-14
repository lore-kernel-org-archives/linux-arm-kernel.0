From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Mar 2013 01:59:00 +0100
Subject: [PATCH 1/3] ARM: EXYNOS5250: dts: Declare the gic as a15 compatible
In-Reply-To: <1363222742-15220-1-git-send-email-agraf@suse.de>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
Message-ID: <1363222742-15220-2-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC in the exynos5250 SoC is A15 compliant. Show this through
the device tree, so that we can use the GIC for KVM.

Also add the respective A15 memory regions and interrupt links.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm/boot/dts/exynos5250.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b1ac73e..768cb42 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -47,10 +47,14 @@
 	};
 
 	gic:interrupt-controller at 10481000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
+		reg = <0x10481000 0x1000>,
+		      <0x10482000 0x1000>,
+		      <0x10484000 0x2000>,
+		      <0x10486000 0x2000>;
+		interrupts = <1 9 0xf04>;
 	};
 
 	combiner:interrupt-controller at 10440000 {
-- 
1.7.10.4
