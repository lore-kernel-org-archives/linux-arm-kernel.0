From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:02 -0500
Subject: [PATCH 04/15] ARM: dts: exynos: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/exynos5440.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 77d35bb92950..d86da2c768fa 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -306,6 +306,7 @@
 		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
 			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
+		bus-range = <0x00 0xff>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 53>;
@@ -329,6 +330,7 @@
 		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
 			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
+		bus-range = <0x00 0xff>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 56>;
-- 
2.10.1
