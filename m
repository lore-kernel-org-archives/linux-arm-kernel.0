From: m.purski@samsung.com (Maciej Purski)
Date: Thu, 12 Oct 2017 14:36:05 +0200
Subject: [PATCH v2 4/4] ARM: dts: Add ti-max-expected-current-microamp
 properties for ina231 in Odroid XU3
In-Reply-To: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
References: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
 <CGME20171012123642eucas1p2878b47147404d6699eb92f9316f7c1b5@eucas1p2.samsung.com>
Message-ID: <1507811765-31005-5-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set max expected current to values required by the documentation,
in order to achieve desired precision.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 9ed6564..bbad001 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -28,6 +28,7 @@
 		compatible = "ti,ina231";
 		reg = <0x40>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <9000>;
 	};
 
 	/* memory: VDD_MEM */
@@ -35,6 +36,7 @@
 		compatible = "ti,ina231";
 		reg = <0x41>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <3000>;
 	};
 
 	/* GPU: VDD_G3D */
@@ -42,6 +44,7 @@
 		compatible = "ti,ina231";
 		reg = <0x44>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <5000>;
 	};
 
 	/* A7 cluster: VDD_KFC */
@@ -49,6 +52,7 @@
 		compatible = "ti,ina231";
 		reg = <0x45>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <2000>;
 	};
 };
 
-- 
2.7.4
