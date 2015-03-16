From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 11:28:28 +0100
Subject: [PATCH 1/3] ARM: dts: Define stdout-path property for Peach boards
In-Reply-To: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1426501710-24177-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel can use as the default console a serial port if is defined
as stdout device in the Device Tree.

This allows a board to be booted without the need of having a console
parameter in the kernel command line.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index d0ee55f4d09f..3f4e2feaa927 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -43,6 +43,10 @@
 		pinctrl-names = "default";
 	};
 
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
 	fixed-rate-clocks {
 		oscclk {
 			compatible = "samsung,exynos5420-oscclk";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7ea1d66dd719..c833bacf873b 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -42,6 +42,10 @@
 		pinctrl-names = "default";
 	};
 
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
 	fixed-rate-clocks {
 		oscclk {
 			compatible = "samsung,exynos5420-oscclk";
-- 
2.1.4
