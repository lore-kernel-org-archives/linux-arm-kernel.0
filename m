From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 20:35:26 +0300
Subject: [PATCH 5/5] ARM: dts: omap5-board-common: Add phandle for mclk clock
 for twl6040
In-Reply-To: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464802526-16372-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

The xref_xtal clock is used y twl6040 as mclk. It is needed for the HPPLL
internally.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index dc759a3..bd0e315 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -606,8 +606,8 @@
 		v2v1-supply = <&smps9_reg>;
 		enable-active-high;
 
-		clocks = <&clk32kgaudio>;
-		clock-names = "clk32k";
+		clocks = <&clk32kgaudio>, <&fref_xtal_ck>;
+		clock-names = "clk32k", "mclk";
 	};
 };
 
-- 
1.9.1
