From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:56 -0600
Subject: [PATCH 4/9] ARM: dt: tegra: format regs properties consistently
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Place each reg "entry" on its own line, and wrap the whole list in
<> rather than each individual entry.

The convention chosen here is slightly arbitrary, but is not consistent
throughout all Tegra files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    4 ++--
 arch/arm/boot/dts/tegra30.dtsi |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index a6b1351..7f718bd 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -13,8 +13,8 @@
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = <0x50041000 0x1000>,
-		      <0x50040100 0x0100>;
+		reg = <0x50041000 0x1000
+		       0x50040100 0x0100>;
 	};
 
 	pmu {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 45547ad..b52378a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -13,8 +13,8 @@
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = <0x50041000 0x1000>,
-		      <0x50040100 0x0100>;
+		reg = <0x50041000 0x1000
+		       0x50040100 0x0100>;
 	};
 
 	pmu {
@@ -186,7 +186,8 @@
 
 	ahub {
 		compatible = "nvidia,tegra30-ahub";
-		reg = <0x70080000 0x200 0x70080200 0x100>;
+		reg = <0x70080000 0x200
+		       0x70080200 0x100>;
 		interrupts = <0 103 0x04>;
 		nvidia,dma-request-selector = <&apbdma 1>;
 
-- 
1.7.0.4
