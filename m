From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Nov 2014 10:32:34 +0100
Subject: [PATCH v7 09/12] ARM: tegra: Enable IOMMU for display controllers on
 Tegra30
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1415871157-21968-10-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add iommus properties to the device tree nodes for the two display
controllers found on Tegra30. This will allow the display controllers to
map physically non-contiguous buffers to I/O virtual contiguous address
spaces so that they can be used for scan-out.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 0d20058afe9d..99475f6e76a3 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra30-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/memory/tegra30-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -166,6 +167,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DC>;
+
 			nvidia,head = <0>;
 
 			rgb {
@@ -183,6 +186,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
+
 			nvidia,head = <1>;
 
 			rgb {
-- 
2.1.3
