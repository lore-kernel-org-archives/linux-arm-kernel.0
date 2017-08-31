From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 31 Aug 2017 15:48:46 +0530
Subject: [PATCH v2 3/6] ARM: dts: dra7: Increase max-voltage of pbias regulator
In-Reply-To: <20170831101849.9489-1-kishon@ti.com>
References: <20170831101849.9489-1-kishon@ti.com>
Message-ID: <20170831101849.9489-4-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravikumar Kattekola <rk@ti.com>

As per recent TRM, PBIAS cell on dra7 devices supports
3.3V and not 3.0V as documented earlier.

Update PBIAS regulator max voltage to match this.

Document reference:
SPRUI30C ? DRA75x, DRA74x Technical reference manual- November 2016

Tested on:
DRA75x PG 2.0 REV H EVM

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0f0f6f58bd18..fc14e48b482e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,7 +170,7 @@
 						pbias_mmc_reg: pbias_mmc_omap5 {
 							regulator-name = "pbias_mmc_omap5";
 							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3000000>;
+							regulator-max-microvolt = <3300000>;
 						};
 					};
 
-- 
2.11.0
