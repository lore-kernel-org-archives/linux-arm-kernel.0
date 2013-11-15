From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 15 Nov 2013 17:16:40 -0300
Subject: [PATCH] ARM: sunxi: dt: add EMAC aliases
Message-ID: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-Boot uses the ethernet0 alias to locate the right node to fill in
the MAC address of the first ethernet interface. This patch adds the
alias on all the sunxi boards with EMAC and an ethernet port. In this
way, people using ethernet in U-Boot (eg, for tftp) can keep a consistent
address on both U-Boot and Linux with no additional effort.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Hi everyone,

I have tested this on a cubieboard2 and found it to work as intended, 
and I don't see why it wouldn't work on the other boards, given that 
the U-Boot codebase is shared. It may be worth submitting this for 
3.13-rc0, but I'm not the one that has to make that call :)

Cheers,

Emilio

 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 1 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 1 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 4 ++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 4 ++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 4 ++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  | 4 ++++
 6 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index eb4d73b..6e56986 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -20,6 +20,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &emac;
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 425a7db..c2e251d 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -20,6 +20,7 @@
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
+		ethernet0 = &emac;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index b3ae51f..551ccbd 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -18,6 +18,10 @@
 	model = "Miniand Hackberry";
 	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 88ec795..bb48737 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -18,6 +18,10 @@
 	model = "Olimex A10s-Olinuxino Micro";
 	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 15e625e..cad4c19 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -18,6 +18,10 @@
 	model = "Cubietech Cubieboard2";
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9e77855..39e1fd0 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -18,6 +18,10 @@
 	model = "Olimex A20-Olinuxino Micro";
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
-- 
1.8.4.2
