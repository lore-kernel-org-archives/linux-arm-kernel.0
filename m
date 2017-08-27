From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 27 Aug 2017 21:02:31 +0900
Subject: [PATCH 2/2] ARM: dts: uniphier: fix size of sdctrl nodes
In-Reply-To: <1503835351-9685-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503835351-9685-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1503835351-9685-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All registers are located within 0x400 size from the base address.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pro5.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 41a6493ed29a..b026bcd42a06 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -292,7 +292,7 @@
 		sdctrl at 59810000 {
 			compatible = "socionext,uniphier-pro5-sdctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x59810000 0x800>;
+			reg = <0x59810000 0x400>;
 
 			sd_clk: clock {
 				compatible = "socionext,uniphier-pro5-sd-clock";
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 37bbaa4b4de5..90b020c95083 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -276,7 +276,7 @@
 		sdctrl at 59810000 {
 			compatible = "socionext,uniphier-pxs2-sdctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x59810000 0x800>;
+			reg = <0x59810000 0x400>;
 
 			sd_clk: clock {
 				compatible = "socionext,uniphier-pxs2-sd-clock";
-- 
2.7.4
