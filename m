From: tony@atomide.com (Tony Lindgren)
Date: Wed, 02 Oct 2013 22:42:11 -0700
Subject: [PATCH 1/6] ARM: dts: Fix pinctrl mask for omap3
In-Reply-To: <20131003054104.8941.88857.stgit@localhost>
References: <20131003054104.8941.88857.stgit@localhost>
Message-ID: <20131003054211.8941.9679.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wake-up interrupt bit is available on omap3/4/5 processors
unlike what we claim. Without fixing it we cannot use it on
omap3 and the system configured for wake-up events will just
hang on wake-up.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi       |    4 ++--
 arch/arm/mach-omap2/mux.h          |    4 +---
 include/dt-bindings/pinctrl/omap.h |    4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7d95cda..b41bd57 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -108,7 +108,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7f1f>;
+			pinctrl-single,function-mask = <0xff1f>;
 		};
 
 		omap3_pmx_wkup: pinmux at 0x48002a00 {
@@ -117,7 +117,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7f1f>;
+			pinctrl-single,function-mask = <0xff1f>;
 		};
 
 		gpio1: gpio at 48310000 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 5d2080e..16f78a9 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -28,7 +28,7 @@
 #define OMAP_PULL_UP			(1 << 4)
 #define OMAP_ALTELECTRICALSEL		(1 << 5)
 
-/* 34xx specific mux bit defines */
+/* omap3/4/5 specific mux bit defines */
 #define OMAP_INPUT_EN			(1 << 8)
 #define OMAP_OFF_EN			(1 << 9)
 #define OMAP_OFFOUT_EN			(1 << 10)
@@ -36,8 +36,6 @@
 #define OMAP_OFF_PULL_EN		(1 << 12)
 #define OMAP_OFF_PULL_UP		(1 << 13)
 #define OMAP_WAKEUP_EN			(1 << 14)
-
-/* 44xx specific mux bit defines */
 #define OMAP_WAKEUP_EVENT		(1 << 15)
 
 /* Active pin states */
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index edbd250..bed35e3 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -23,7 +23,7 @@
 #define PULL_UP			(1 << 4)
 #define ALTELECTRICALSEL	(1 << 5)
 
-/* 34xx specific mux bit defines */
+/* omap3/4/5 specific mux bit defines */
 #define INPUT_EN		(1 << 8)
 #define OFF_EN			(1 << 9)
 #define OFFOUT_EN		(1 << 10)
@@ -31,8 +31,6 @@
 #define OFF_PULL_EN		(1 << 12)
 #define OFF_PULL_UP		(1 << 13)
 #define WAKEUP_EN		(1 << 14)
-
-/* 44xx specific mux bit defines */
 #define WAKEUP_EVENT		(1 << 15)
 
 /* Active pin states */
