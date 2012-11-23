From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Nov 2012 11:11:23 +0900
Subject: [PATCH] ARM: dts: Add node for GMAC for exynos5440
Message-ID: <110101cdc91f$d658b7c0$830a2740$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Byungho An <bh74.an@samsung.com>

This patch adds node for GMAC for exynos5440.

Signed-off-by: Byungho An <bh74.an@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 024269d..b8de8e3 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -131,6 +131,15 @@
 		interrupts = <0 1 0>;
 	};
 
+	gmac: ethernet at 00230000 {
+		compatible = "snps,dwmac-3.70a";
+		reg = <0x00230000 0x8000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 31 4>;
+		interrupt-name = "macirq";
+		phy-mode = "sgmii";
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
