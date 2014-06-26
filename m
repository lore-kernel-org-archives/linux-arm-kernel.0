From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jun 2014 22:49:46 +0200
Subject: [RFC 06/10] ARM: tegra: tegra124: Enable IOMMU for display controllers
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403815790-8548-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add an iommus property to each of the display controllers and encode the
SWGROUP in the specifier.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index efa0f0c519be..82751d2878c4 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/memory/tegra124-mc.h>
 
 #include "skeleton.dtsi"
 
@@ -104,6 +105,8 @@
 			reset-names = "dc";
 
 			nvidia,head = <0>;
+
+			iommus = <&mc TEGRA_SWGROUP_DC>;
 		};
 
 		dc at 0,54240000 {
@@ -117,6 +120,8 @@
 			reset-names = "dc";
 
 			nvidia,head = <1>;
+
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
 		};
 
 		hdmi at 0,54280000 {
-- 
2.0.0
