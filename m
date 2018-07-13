From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 13 Jul 2018 13:49:57 +0200
Subject: [PATCH] ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
Message-ID: <20180713114957.32361-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator should not be defined inside the SoC dtsi file.
vddio_ao18 is already defined in the S400 board dts anyway.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Kevin,

This patch fixes a problem in a patch [0] you have applied recently.
I did not put a Fixes tag because the branch on which you've applied it
is not public yet (unknown sha1)

If you decide to pick this patch, could you please add the Fixes tag?
You could also squash the two patches together, if you prefer.

Cheers
Jerome

[0] https://lkml.kernel.org/r/7hmuv0nkss.fsf at baylibre.com

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a936d6535ce7..d4dc87ae72a4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -92,13 +92,6 @@
 		method = "smc";
 	};
 
-	vddio_ao18: regulator-vddio_ao18 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_AO18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.14.4
