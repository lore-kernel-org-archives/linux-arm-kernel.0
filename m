From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:45 +0100
Subject: [PATCH 42/54] arm64: dts: renesas: r8a7795: Increase the number of
 GPIO bank 1 ports to 29
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <eb14ed1ad7b6750b6b82e7f556f2c1c340f35b8f.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch changes the number of GPIO bank 1 ports to 29 because GP-1-28
port pin of R8A7795 ES2.0 SoC support was added.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: 291e0c4994d0813f ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
[geert: Keep 28 GPIOs on H3 ES1.x after r8a7795.dtsi sharing]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 29b52d89c78a..26769a11a190 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -109,6 +109,10 @@
 	};
 };
 
+&gpio1 {
+	gpio-ranges = <&pfc 0 32 28>;
+};
+
 &ipmmu_vi0 {
 	renesas,ipmmu-main = <&ipmmu_mm 11>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a438d58f1b50..6db4f10376a1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -240,7 +240,7 @@
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
-			gpio-ranges = <&pfc 0 32 28>;
+			gpio-ranges = <&pfc 0 32 29>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
-- 
2.11.0
