From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 25 Jun 2018 09:25:06 +0100
Subject: [PATCH v6 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
In-Reply-To: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1529915110-5867-4-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a special enable method for the second CA7 of the R9A06G032
as well as the default value for the "cpu-release-addr" property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 353e06f..3e45375 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -30,6 +30,8 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0 0x4000c204>;
 		};
 	};
 
-- 
2.7.4
