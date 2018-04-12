From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 12 Apr 2018 11:31:31 +0900
Subject: [PATCH] arm64: dts: uniphier: fix input delay value for legacy mode
 of eMMC
Message-ID: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property of the legacy mode for the eMMC PHY turned out to
be worng.  Some eMMC devices are unstable due to the set-up/hold
timing violation.  Correct the delay value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index e62bda1..c32dd34 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -414,7 +414,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 9efe20d..3a5ed78 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -519,7 +519,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 7c8f710..e85d6dd 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -334,7 +334,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
-- 
2.7.4
