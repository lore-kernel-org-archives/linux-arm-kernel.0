From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 22 Oct 2015 02:04:41 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: fix "gpio-ranges" props
In-Reply-To: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
Message-ID: <14605037.EZjgJcsdsk@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On R8A7790, GPIO banks 1 and 2 are missing  pins 30 and 31.  Correct the
"gpio-ranges" properties of the corresponding device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20151019-v4.3-rc6' of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7790.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -143,7 +143,7 @@
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 32 32>;
+		gpio-ranges = <&pfc 0 32 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
@@ -156,7 +156,7 @@
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 64 32>;
+		gpio-ranges = <&pfc 0 64 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
