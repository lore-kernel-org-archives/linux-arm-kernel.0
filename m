From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 18:42:23 +0100
Subject: [PATCH] ARM: dts: samsung: Remove unused samsung_k3pe0e000b
Message-ID: <20180109174223.6303-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only user of DTSI for Samsung K3PE0E000B memory was removed in
commit fa63d037283a ("ARM: dts: omap5: Make uevm as the official board
and deprecate sevm support") so get rid of this DTSI as well.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS                               |  1 -
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi | 68 -------------------------------
 2 files changed, 69 deletions(-)
 delete mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 2842ce504fe3..36a5a13a1af4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1849,7 +1849,6 @@ Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
 S:	Maintained
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/s5p*
-F:	arch/arm/boot/dts/samsung*
 F:	arch/arm/boot/dts/exynos*
 F:	arch/arm64/boot/dts/exynos/
 F:	arch/arm/plat-samsung/
diff --git a/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi b/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
deleted file mode 100644
index dbdda36179ee..000000000000
--- a/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Timings and Geometry for Samsung K3PE0E000B memory part
- */
-
-/ {
-	samsung_K3PE0E000B: lpddr2 {
-		compatible	= "Samsung,K3PE0E000B","jedec,lpddr2-s4";
-		density		= <4096>;
-		io-width	= <32>;
-
-		tRPab-min-tck	= <3>;
-		tRCD-min-tck	= <3>;
-		tWR-min-tck	= <3>;
-		tRASmin-min-tck	= <3>;
-		tRRD-min-tck	= <2>;
-		tWTR-min-tck	= <2>;
-		tXP-min-tck	= <2>;
-		tRTP-min-tck	= <2>;
-		tCKE-min-tck	= <3>;
-		tCKESR-min-tck	= <3>;
-		tFAW-min-tck	= <8>;
-
-		timings_samsung_K3PE0E000B_533MHz: lpddr2-timings at 0 {
-			compatible	= "jedec,lpddr2-timings";
-			min-freq	= <10000000>;
-			max-freq	= <533333333>;
-			tRPab		= <21000>;
-			tRCD		= <18000>;
-			tWR		= <15000>;
-			tRAS-min	= <42000>;
-			tRRD		= <10000>;
-			tWTR		= <7500>;
-			tXP		= <7500>;
-			tRTP		= <7500>;
-			tCKESR		= <15000>;
-			tDQSCK-max	= <5500>;
-			tFAW		= <50000>;
-			tZQCS		= <90000>;
-			tZQCL		= <360000>;
-			tZQinit		= <1000000>;
-			tRAS-max-ns	= <70000>;
-			tDQSCK-max-derated = <6000>;
-		};
-
-		timings_samsung_K3PE0E000B_266MHz: lpddr2-timings at 1 {
-			compatible	= "jedec,lpddr2-timings";
-			min-freq	= <10000000>;
-			max-freq	= <266666666>;
-			tRPab		= <21000>;
-			tRCD		= <18000>;
-			tWR		= <15000>;
-			tRAS-min	= <42000>;
-			tRRD		= <10000>;
-			tWTR		= <7500>;
-			tXP		= <7500>;
-			tRTP		= <7500>;
-			tCKESR		= <15000>;
-			tDQSCK-max	= <5500>;
-			tFAW		= <50000>;
-			tZQCS		= <90000>;
-			tZQCL		= <360000>;
-			tZQinit		= <1000000>;
-			tRAS-max-ns	= <70000>;
-			tDQSCK-max-derated = <6000>;
-		};
-	};
-};
-- 
2.11.0
