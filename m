From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Mar 2018 15:53:15 +0200
Subject: [PATCH v2 6/6] ARM: dts: omap5-board-common: Add phandle for mclk
 clock for twl6040
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Message-ID: <20180314135315.11215-7-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xref_xtal clock is used by twl6040 as mclk. It is needed for the HPPLL
internally.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 1b20838bb9a4..3b2244560c28 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -659,8 +659,8 @@
 		v2v1-supply = <&smps9_reg>;
 		enable-active-high;
 
-		clocks = <&clk32kgaudio>;
-		clock-names = "clk32k";
+		clocks = <&clk32kgaudio>, <&fref_xtal_ck>;
+		clock-names = "clk32k", "mclk";
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
