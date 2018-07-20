From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:15 +0200
Subject: [PATCH 7/9] ARM: dts: Renesas R9A06G032 SMP enable method
In-Reply-To: <cover.1532086734.git.horms+renesas@verge.net.au>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
Message-ID: <784cdc0263f46aff6b4e70fe4052123b264a395f.1532086734.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <michel.pollet@bp.renesas.com>

Add a special enable method for the second CA7 of the R9A06G032
as well as the default value for the "cpu-release-addr" property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 339d0958011e..afe29c95a006 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -29,6 +29,8 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clocks = <&sysctrl 84>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0 0x4000c204>;
 		};
 	};
 
-- 
2.11.0
