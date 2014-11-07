From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Nov 2014 17:01:00 +0100
Subject: [PATCH v6 09/12] ARM: tegra: Enable IOMMU for display controllers on
 Tegra30
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1415376063-17205-10-git-send-email-thierry.reding@gmail.com>
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
index fa7e5b642434..976eb9ba8659 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra30-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/memory/tegra30-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -174,6 +175,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DC>;
+
 			nvidia,head = <0>;
 
 			rgb {
@@ -191,6 +194,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
+
 			nvidia,head = <1>;
 
 			rgb {
-- 
2.1.3
