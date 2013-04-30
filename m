From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Apr 2013 11:45:33 +0200
Subject: [PATCH] ARM: sunxi: Fix Mini X-plus device tree build
Message-ID: <1367315134-20977-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b00adbe0 ("ARM: sunxi: Rename uart nodes to serial") changed the
node names in the DTSI, changes that were not accordingly made to the
Mini X-Plus device tree. This breakage slipped through because it was
not properly declared in the Makefile.

Fix both issues.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 This is 3.10-rc* material.

 arch/arm/boot/dts/Makefile                 | 4 +++-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..6d774d0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -147,7 +147,9 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear320-evb.dtb \
 	spear320-hmi.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
+dtb-$(CONFIG_ARCH_SUNXI) += \
+	sun4i-a10-cubieboard.dtb \
+	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
 	sun5i-a13-olinuxino.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 4a7c35d..078ed7f 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -22,8 +22,8 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc {
-		uart0: uart at 01c28000 {
+	soc at 01c20000 {
+		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
-- 
1.8.1.2
