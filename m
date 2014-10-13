From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Oct 2014 12:33:53 +0200
Subject: [PATCH 11/12] ARM: tegra: Enable IOMMU for display controllers on
 Tegra114
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1413196434-5292-11-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add iommus properties to the device tree nodes for the two display
controllers found on Tegra114. This will allow the display controllers
to map physically non-contiguous buffers to I/O virtual contiguous
address spaces so that they can be used for scan-out.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 2c26b07c11ed..c8c3b6438b4d 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra114-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -57,6 +58,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DC>;
+
 			nvidia,head = <0>;
 
 			rgb {
@@ -74,6 +77,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
+
 			nvidia,head = <1>;
 
 			rgb {
-- 
2.1.2
