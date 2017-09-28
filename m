From: m.purski@samsung.com (Maciej Purski)
Date: Thu, 28 Sep 2017 14:50:15 +0200
Subject: [PATCH 4/4] ARM: dts: Add max-expected-current properties for
 ina231 in Odroid XU3
In-Reply-To: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
References: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
 <CGME20170928125109eucas1p1287998eb55b09d5eba9dc929f7dcb284@eucas1p1.samsung.com>
Message-ID: <1506603015-27202-5-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set max-expected-current to values required by the documentation,
in order to achieve desired precision.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 9ed6564..aa19374 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -28,6 +28,7 @@
 		compatible = "ti,ina231";
 		reg = <0x40>;
 		shunt-resistor = <10000>;
+		max-expected-current = <9000>;
 	};
 
 	/* memory: VDD_MEM */
@@ -35,6 +36,7 @@
 		compatible = "ti,ina231";
 		reg = <0x41>;
 		shunt-resistor = <10000>;
+		max-expected-current = <3000>;
 	};
 
 	/* GPU: VDD_G3D */
@@ -42,6 +44,7 @@
 		compatible = "ti,ina231";
 		reg = <0x44>;
 		shunt-resistor = <10000>;
+		max-expected-current = <5000>;
 	};
 
 	/* A7 cluster: VDD_KFC */
@@ -49,6 +52,7 @@
 		compatible = "ti,ina231";
 		reg = <0x45>;
 		shunt-resistor = <10000>;
+		max-expected-current = <2000>;
 	};
 };
 
-- 
2.7.4
