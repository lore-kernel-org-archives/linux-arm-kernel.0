From: niklas.cassel@axis.com (Niklas Cassel)
Date: Wed, 23 Nov 2016 15:24:51 +0100
Subject: [PATCH 2/4] ARM: dts: exynos: specify snps,
 dwmac in compatible string for gmac
Message-ID: <1479911091-19812-1-git-send-email-niklass@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas Cassel <niklas.cassel@axis.com>

devicetree binding for stmmac states:
- compatible: Should be "snps,dwmac-<ip_version>", "snps,dwmac"
	For backwards compatibility: "st,spear600-gmac" is also supported.

No functional change intended.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/exynos5440.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 97c9f0e38526..2a2e570bbee6 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -197,7 +197,7 @@
 	};
 
 	gmac: ethernet at 00230000 {
-		compatible = "snps,dwmac-3.70a";
+		compatible = "snps,dwmac-3.70a", "snps,dwmac";
 		reg = <0x00230000 0x8000>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 31 4>;
-- 
2.1.4
