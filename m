From: bilhuang@nvidia.com (Bill Huang)
Date: Sun, 18 Aug 2013 23:33:48 -0700
Subject: [PATCH 1/1] ARM: tegra: configure power off for Dalmore
Message-ID: <1376894028-30060-1-git-send-email-bilhuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT property to tell the regulator to register pm_power_off to make
"shutdown" work.

Signed-off-by: Bill Huang <bilhuang@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 45056a2..6023028 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -845,6 +845,8 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
+			ti,system-power-controller;
+
 			palmas_gpio: gpio {
 				compatible = "ti,palmas-gpio";
 				gpio-controller;
-- 
1.7.9.5
