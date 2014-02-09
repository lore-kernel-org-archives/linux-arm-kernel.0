From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun,  9 Feb 2014 14:12:35 +0200
Subject: [PATCH 1/2] ARM: dts: N9/N950: fix boot hang with 3.14-rc1
Message-ID: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

N9/N950 does not boot anymore with 3.14-rc1, because SoC compatible
property is missing. Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n9.dts   | 2 +-
 arch/arm/boot/dts/omap3-n950.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39828ce464ee..9938b5dc1909 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "Nokia N9";
-	compatible = "nokia,omap3-n9", "ti,omap3";
+	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index b076a526b999..261c5589bfa3 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "Nokia N950";
-	compatible = "nokia,omap3-n950", "ti,omap3";
+	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
 };
-- 
1.8.5.3
