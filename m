From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:43 +0530
Subject: [PATCH RFC 3/8] ARM: dts: Add PPMU device tree support for Exynos5250
In-Reply-To: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
References: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398544728-2075-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPMU is required by the exynos5250 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../bindings/arm/exynos/ppmu-exynos5.txt           | 29 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |  9 +++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
new file mode 100644
index 0000000..fc29664
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
@@ -0,0 +1,29 @@
+Exynos PPMU driver
+-------------------
+
+Performance events are primitive values used to get performance data. These
+events provide information about the behavior of the SoC that can be used
+when analyzing system performance. These events are made visible using the
+PPMU logic.
+Exynos PPMU driver is used by the exynos5 devfreq drivers to control the
+bus frequency/voltage.
+
+Required properties:
+- compatible: should be one of the following.
+	* samsung,exynos5250-ppmu - for exynos5250 type ppmu.
+	* samsung,exynos5420-ppmu - for exynos5420 type ppmu.
+- reg:
+	* physical base address of the PPMUs (e.g DDR, Right Bus, Left bus etc)
+	and length of memory mapped region.
+
+Example:
+--------
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x10C40000 0x2000
+		       0x10C50000 0x2000
+		       0x10C60000 0x2000
+		       0x10CB0000 0x2000
+		       0x13660000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..2bf8369 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -736,4 +736,13 @@
 		clocks = <&clock 348>;
 		clock-names = "secss";
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x10C40000 0x2000	/* PPMU_DDR_C */
+		       0x10C50000 0x2000	/* PPMU_DDR_R1 */
+		       0x10CB0000 0x2000	/* PPMU_DDR_L */
+		       0x13660000 0x2000	/* PPMU_DDR_RIGHT */
+		       0x10C60000 0x2000>;	/* PPMU_DDR_CPU */
+	};
 };
-- 
1.8.3.2
