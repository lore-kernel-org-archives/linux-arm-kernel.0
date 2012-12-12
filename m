From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Dec 2012 17:08:23 +0100
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
Message-ID: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is several different SoCs sharing the sun5i codename: A10s, A12
and A13. Since there is enough differences to not consider those the
same SoCs, change a bit the naming scheme to reflect this.

Moreover, some boards like the olinuxino come in A10s and A13 variants,
which also share the same SoC codename.

So change the naming scheme to reflect both the codename and the market
name of the SoCs used in the dtsi and in the board files

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                         |    4 ++--
 ...n4i-cubieboard.dts => sun4i-a10-cubieboard.dts} |    4 ++--
 arch/arm/boot/dts/{sun4i.dtsi => sun4i-a10.dtsi}   |    0
 ...sun5i-olinuxino.dts => sun5i-a13-olinuxino.dts} |    4 ++--
 arch/arm/boot/dts/{sun5i.dtsi => sun5i-a13.dtsi}   |    0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{sun4i-cubieboard.dts => sun4i-a10-cubieboard.dts} (87%)
 rename arch/arm/boot/dts/{sun4i.dtsi => sun4i-a10.dtsi} (100%)
 rename arch/arm/boot/dts/{sun5i-olinuxino.dts => sun5i-a13-olinuxino.dts} (86%)
 rename arch/arm/boot/dts/{sun5i.dtsi => sun5i-a13.dtsi} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4dd567b..021d480 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -84,8 +84,8 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear310-evb.dtb \
 	spear320-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += sun4i-cubieboard.dtb \
-	sun5i-olinuxino.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
+	sun5i-a13-olinuxino.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
diff --git a/arch/arm/boot/dts/sun4i-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
similarity index 87%
rename from arch/arm/boot/dts/sun4i-cubieboard.dts
rename to arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index f4ca126..5cab825 100644
--- a/arch/arm/boot/dts/sun4i-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -11,11 +11,11 @@
  */
 
 /dts-v1/;
-/include/ "sun4i.dtsi"
+/include/ "sun4i-a10.dtsi"
 
 / {
 	model = "Cubietech Cubieboard";
-	compatible = "cubietech,cubieboard", "allwinner,sun4i";
+	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/boot/dts/sun4i.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun4i.dtsi
rename to arch/arm/boot/dts/sun4i-a10.dtsi
diff --git a/arch/arm/boot/dts/sun5i-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
similarity index 86%
rename from arch/arm/boot/dts/sun5i-olinuxino.dts
rename to arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index d6ff889..498a091 100644
--- a/arch/arm/boot/dts/sun5i-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -12,11 +12,11 @@
  */
 
 /dts-v1/;
-/include/ "sun5i.dtsi"
+/include/ "sun5i-a13.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino";
-	compatible = "olimex,a13-olinuxino", "allwinner,sun5i";
+	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i.dtsi
rename to arch/arm/boot/dts/sun5i-a13.dtsi
-- 
1.7.9.5
