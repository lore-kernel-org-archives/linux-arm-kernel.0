From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 22 May 2014 22:51:58 +0530
Subject: [PATCH RFC v2 3/7] ARM: dts: Add PPMU device tree support for
 Exynos5250
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPMU is required by the exynos5250 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../bindings/arm/exynos/ppmu-exynos5.txt           |   27 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    8 ++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
new file mode 100644
index 0000000..08a4aaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
@@ -0,0 +1,27 @@
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
+- compatible: "samsung,exynos5250-int-busfreq", "samsung,exynos5420-int-busfreq"
+- reg:
+	* physical base address of the PPMUs (e.g DDR, Right Bus, Left bus etc)
+	and length of memory mapped region.
+
+Example:
+--------
+
+	ppmu {
+		compatible = "samsung,exynos5250-int-busfreq";
+		reg = <0x10C40000 0x2000
+		       0x10C50000 0x2000
+		       0x10C60000 0x2000
+		       0x10CB0000 0x2000
+		       0x13660000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 68a3e6f..f20355a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -750,4 +750,12 @@
 		clocks = <&clock 348>;
 		clock-names = "secss";
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5250-int-busfreq";
+	            reg = <0x10C40000 0x2000	/* PPMU_DDR_C */
+			   0x10C50000 0x2000	/* PPMU_DDR_L */
+			   0x10CB0000 0x2000	/* PPMU_DDR_R */
+			   0x13660000 0x2000>;	/* PPMU_RIGHT */
+	};
 };
-- 
1.7.9.5
