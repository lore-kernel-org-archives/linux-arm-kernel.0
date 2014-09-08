From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:27:48 +0900
Subject: [PATCH 5/5] ARM: shmobile: r8a7779: Use SoC-specific TMU compat string
In-Reply-To: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
References: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410136068-32220-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general Renesas hardware is not documented to the extent
where the relationship between IP blocks on different SoCs can be assumed
although they may appear to operate the same way. Furthermore the
documentation typically does not specify a version for individual
IP blocks. For these reasons a convention of using the SoC name in place
of a version and providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
a number of drivers for Renesas hardware. The purpose of this patch is to
make use of the SoC-specific CMT compat string for the r8a7779 TMU
clock source.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d25ed7b..7cfba9a 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -261,7 +261,7 @@
 	};
 
 	tmu0: timer at ffd80000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd80000 0x30>;
 		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
@@ -275,7 +275,7 @@
 	};
 
 	tmu1: timer at ffd81000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd81000 0x30>;
 		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
@@ -289,7 +289,7 @@
 	};
 
 	tmu2: timer at ffd82000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd82000 0x30>;
 		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.0.1
