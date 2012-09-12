From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 12 Sep 2012 14:45:52 -0500
Subject: [PATCH v2 9/9] arm/dts: OMAP3/4: Add iommu nodes
In-Reply-To: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1347479152-588-10-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for iommu DT, to interface with hwmods.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/boot/dts/omap3.dtsi |   12 +++++++++++-
 arch/arm/boot/dts/omap4.dtsi |   17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8109471..7500136 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -38,12 +38,17 @@
 		};
 
 		iva {
-			compatible = "ti,iva2.2";
+			compatible = "ti,iva2.2", "simple-bus";
 			ti,hwmods = "iva";
 
 			dsp {
 				compatible = "ti,omap3-c64";
 			};
+
+			mmu_iva: mmu_iva at 5d000000 {
+				compatible = "ti,omap3-iommu";
+				ti,hwmods = "mmu_iva";
+			};
 		};
 	};
 
@@ -216,6 +221,11 @@
 			ti,hwmods = "mmc3";
 		};
 
+		mmu_isp: mmu_isp at 480bd400 {
+			compatible = "ti,omap3-iommu";
+			ti,hwmods = "mmu_isp";
+		};
+
 		wdt2: wdt at 48314000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..07f3587 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -48,8 +48,23 @@
 		};
 
 		dsp {
-			compatible = "ti,omap3-c64";
+			compatible = "ti,omap3-c64", "simple-bus";
 			ti,hwmods = "dsp";
+
+			mmu_dsp: mmu_dsp at 4a066000 {
+				compatible = "ti,omap4-iommu";
+				ti,hwmods = "mmu_dsp";
+			};
+		};
+
+		ipu {
+			compatible = "ti,omap4-ipu", "simple-bus";
+			ti,hwmods = "ipu";
+
+			mmu_ipu: mmu_ipu at 55082000 {
+				compatible = "ti,omap4-iommu";
+				ti,hwmods = "mmu_ipu";
+			};
 		};
 
 		iva {
-- 
1.7.9.5
