From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 22:53:06 +0100
Subject: [PATCH 1/2] ARM: sun4i: dt: Move the aliases to the DTSI
Message-ID: <1387576387-22122-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aliases are shared across boards are really belong to the DTSI.
Move them there.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      | 4 ----
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 5 -----
 arch/arm/boot/dts/sun4i-a10.dtsi           | 2 ++
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index eb4d73b..d4b081d 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -18,10 +18,6 @@
 	model = "Mele A1000";
 	compatible = "mele,a1000", "allwinner,sun4i-a10";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 425a7db..f1c77e0 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -17,11 +17,6 @@
 	model = "Cubietech Cubieboard";
 	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 0bf70ee..c164d6c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -17,6 +17,8 @@
 
 	aliases {
 		ethernet0 = &emac;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	cpus {
-- 
1.8.4.2
