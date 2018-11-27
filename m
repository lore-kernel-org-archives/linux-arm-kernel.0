From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:13 +0100
Subject: [PATCH 72/77] ARM: dts: sun8i: v3s: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <3d2df36c4b2e62efd774ff40449b359992e55ebb.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our memory node will generate a warning in DTC since the unit address is
not matching the reg property. However, that node will be created by the
bootloader, so we can just remove it entirely in order to remove that
warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 5617dd387fd3..b099d2fbb5cd 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -187,11 +187,6 @@
 		status = "disabled";
 	};
 
-	memory {
-		reg = <0x40000000 0x80000000>;
-		device_type = "memory";
-	};
-
 	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 		opp-shared;
-- 
git-series 0.9.1
