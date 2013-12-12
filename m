From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 12 Dec 2013 17:24:00 +0000
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sies
Message-ID: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a7790.dtsi file has three sdhi nodes which all have the wrong resource
size for their register block. This causes the sh_modbile_sdhi driver to
fail to communicate with card at-all.

Change each sdhi node size from 0x100 to 0x200 to correct this.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Linux SH <linux-sh@vger.kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Tested-by: William Towle <william.towle@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 68b7b87..e218f25 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -254,7 +254,7 @@
 
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee100000 0 0x100>;
+		reg = <0 0xee100000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
@@ -263,7 +263,7 @@
 
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee120000 0 0x100>;
+		reg = <0 0xee120000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
@@ -272,7 +272,7 @@
 
 	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee140000 0 0x100>;
+		reg = <0 0xee140000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
@@ -281,7 +281,7 @@
 
 	sdhi3: sd at ee160000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee160000 0 0x100>;
+		reg = <0 0xee160000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		cap-sd-highspeed;
-- 
1.8.5.1
