From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Jul 2017 16:09:38 -0500
Subject: [PATCH v2] ARM: dts: exynos: fix PCI bus dtc warnings
In-Reply-To: <20170726210943.6875-1-robh@kernel.org>
References: <20170726210943.6875-1-robh@kernel.org>
Message-ID: <20170726210943.6875-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
v2:
- rebase on v4.13-rc2

 arch/arm/boot/dts/exynos5440.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index bc4954e69f7b..7a00be7ea6d7 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -317,6 +317,7 @@
 		phys = <&pcie_phy0>;
 		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
+		bus-range = <0x00 0xff>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 53>;
@@ -339,6 +340,7 @@
 		phys = <&pcie_phy1>;
 		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
+		bus-range = <0x00 0xff>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 56>;
-- 
2.11.0
