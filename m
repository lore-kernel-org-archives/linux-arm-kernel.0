From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Oct 2016 00:42:43 +0900
Subject: [PATCH 2/2] ARM: dts: uniphier: increase register region size of
 sysctrl node
In-Reply-To: <1476632563-7446-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476632563-7446-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1476632563-7446-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Control node has 0x10000 byte of registers.  The current
reg size must be expanded to use the cpufreq driver because the
registers controlling CPU frequency are located at offset 0x8000.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
index 8c8a851..d067f38 100644
--- a/arch/arm/boot/dts/uniphier-common32.dtsi
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -183,7 +183,7 @@
 		sysctrl at 61840000 {
 			compatible = "socionext,uniphier-sysctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x61840000 0x4000>;
+			reg = <0x61840000 0x10000>;
 
 			sys_clk: clock {
 				#clock-cells = <1>;
-- 
1.9.1
