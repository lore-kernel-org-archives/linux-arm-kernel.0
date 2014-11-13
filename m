From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Nov 2014 10:32:36 +0100
Subject: [PATCH v7 11/12] ARM: tegra: Enable IOMMU for display controllers on
 Tegra124
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1415871157-21968-12-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add iommus properties to the device tree nodes for the two display
controllers found on Tegra124. This will allow the display controllers
to map physically non-contiguous buffers to I/O virtual contiguous
address spaces so that they can be used for scan-out.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 29b60074bafa..4be06c6ea0c8 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra124-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/memory/tegra124-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -103,6 +104,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DC>;
+
 			nvidia,head = <0>;
 		};
 
@@ -116,6 +119,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
+
 			nvidia,head = <1>;
 		};
 
-- 
2.1.3
