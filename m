From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:46:44 +0900
Subject: [PATCH 1/4] ARM: dts: Add node for GMAC for exynos5440
In-Reply-To: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
References: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1365072407-4320-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Byungho An <bh74.an@samsung.com>

This patch adds node for GMAC for exynos5440
EXYNOS5440 SoC supported by GMAC driver.

Signed-off-by: Byungho An <bh74.an@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 7132358..7bd1f3b 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -147,6 +147,17 @@
 		clock-names = "watchdog";
 	};
 
+	gmac: ethernet at 00230000 {
+		compatible = "snps,dwmac-3.70a";
+		reg = <0x00230000 0x8000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 31 4>;
+		interrupt-names = "macirq";
+		phy-mode = "sgmii";
+		clocks = <&clock 12>;
+		clock-names = "stmmaceth";
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.4.4
