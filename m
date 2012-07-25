From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 25 Jul 2012 17:41:24 +0530
Subject: [PATCH 1/2] ARM: dts: Add nodes for i2s controllers for Samsung
 Exynos5 platforms
In-Reply-To: <1343218285-30535-1-git-send-email-padma.v@samsung.com>
References: <1343218285-30535-1-git-send-email-padma.v@samsung.com>
Message-ID: <1343218285-30535-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the three instances of i2s controllers in Exynos5
platforms. Enable instance i2s 0 for exynos5250 board and disable all
other i2s instances.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 8a5e348..615d1c4 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -109,4 +109,19 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
+
+	i2s_0: i2s at 03830000 {
+		gpios = <&gpz 0 2 0 0>, <&gpz 1 2 0 0>, <&gpz 2 2 0 0>,
+			<&gpz 3 2 0 0>, <&gpz 4 2 0 0>, <&gpz 5 2 0 0>,
+			<&gpz 6 2 0 0>;
+		idma-addr = <0x03000000>;
+	};
+
+	i2s_1: i2s at 12D60000 {
+		status = "disabled";
+	};
+
+	i2s_2: i2s at 12D70000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index a3a2eb2..6ff78ba 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -27,6 +27,9 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		i2s0 = &i2s_0;
+		i2s1 = &i2s_1;
+		i2s2 = &i2s_2;
 	};
 
 	gic:interrupt-controller at 10481000 {
@@ -182,6 +185,31 @@
 		#size-cells = <0>;
 	};
 
+	i2s_0: i2s at 03830000 {
+		compatible = "samsung,samsung-i2s";
+		reg = <0x03830000 0x100>;
+		tx-dma-channel-secondary = <&pdma0 8>;
+		tx-dma-channel = <&pdma0 10>;
+		rx-dma-channel = <&pdma0 9>;
+		supports-6ch;
+		supports-rstclr;
+		supports-secdai;
+	};
+
+	i2s_1: i2s at 12D60000 {
+		compatible = "samsung,samsung-i2s";
+		reg = <0x12D60000 0x100>;
+		tx-dma-channel = <&pdma1 12>;
+		rx-dma-channel = <&pdma1 11>;
+	};
+
+	i2s_2: i2s at 12D70000 {
+		compatible = "samsung,samsung-i2s";
+		reg = <0x12D70000 0x100>;
+		tx-dma-channel = <&pdma0 12>;
+		rx-dma-channel = <&pdma0 11>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.4.4
