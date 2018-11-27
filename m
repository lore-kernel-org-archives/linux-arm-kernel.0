From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:56 +0100
Subject: [PATCH 55/77] ARM: dts: sun8i: a23/a33: Remove unused
 address-cells/size-cells
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <6b72724d16bbef52bde66a99641b34a5d3c942ce.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #address-cells and #size-cells are only relevant for nodes that have
childs with reg properties. Otherwise, DTC will emit a warning saying that
those properties are unnecessary.

Remove them when needed.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index bd8d9e7afcdf..5d79860bef88 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -656,8 +656,6 @@
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			#gpio-cells = <3>;
 
 			r_rsb_pins: r_rsb {
-- 
git-series 0.9.1
