From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:22:42 +0200
Subject: [PATCH RESEND 10/12] ARM: dts: berlin: Add SDHCI controller nodes to
 BG2/BG2CD
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413883364-681-11-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin BG2 has three, BG2CD just one pxav3 compatible
sdhci controllers, add them to the corresponding DT SoC
includes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2.dtsi   | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi |  9 +++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 9d7c810ebd0b..504f1add1938 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -53,6 +53,35 @@
 
 		ranges = <0 0xf7000000 0x1000000>;
 
+		sdhci0: sdhci at ab0000 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab0000 0x200>;
+			clocks = <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
+			clock-names = "io", "core";
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci at ab0800 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab0800 0x200>;
+			clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
+			clock-names = "io", "core";
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sdhci2: sdhci at ab1000 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab1000 0x200>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_NFC_ECC>, <&chip CLKID_NFC>;
+			clock-names = "io", "core";
+			pinctrl-0 = <&emmc_pmux>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
 		l2: l2-cache-controller at ac0000 {
 			compatible = "marvell,tauros3-cache", "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
@@ -252,6 +281,11 @@
 			reg = <0xea0000 0x400>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
+
+			emmc_pmux: emmc-pmux {
+				groups = "G26";
+				function = "emmc";
+			};
 		};
 
 		apb at fc0000 {
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index cc1df65da504..5a19017b5d71 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -45,6 +45,15 @@
 
 		ranges = <0 0xf7000000 0x1000000>;
 
+		sdhci0: sdhci at ab0000 {
+			compatible = "mrvl,pxav3-mmc";
+			reg = <0xab0000 0x200>;
+			clocks = <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
+			clock-names = "io", "core";
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		l2: l2-cache-controller at ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
-- 
2.1.1
