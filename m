From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:42 +0300
Subject: [PATCH v2 07/22] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-8-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a bitmap that indicates which HardWare Accelerators(HWA) are
supported on Tegra114 SoC.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 1f45cf5..9e231eb 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/clock/tegra114-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/memory/tegra-swgroup.h>
 
 #include "skeleton.dtsi"
 
@@ -323,7 +324,7 @@
 		       0x70019228 0x074>;
 		nvidia,#asids = <4>;
 		dma-window = <0 0x40000000>;
-		nvidia,swgroups = <0x18659fe>;
+		nvidia,swgroups = TEGRA114_SWGROUP_ALL;
 		nvidia,ahb = <&ahb>;
 	};
 
-- 
1.7.9.5
