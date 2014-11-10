From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:19 +0900
Subject: [PATCH 2/8] ARM: shmobile: r8a7779 dtsi: Remove unnecessary MMC
 options
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
Message-ID: <92e044aed5aede573ffa1ba2c99212024356e851.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As of commit 81bbbc7278fa109f ("mmc: sdhi: update sh_mobile_sdhi_of_data
for r8a7779"), the driver takes care of r8a7779 specific MMC options.
Hence they can be removed from the dtsi.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Rebased, reworded, added reference]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 7cfba9a..ad83e47 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -314,8 +314,6 @@
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -324,8 +322,6 @@
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -334,8 +330,6 @@
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -344,8 +338,6 @@
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
-- 
2.1.1
