From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:27:46 +0900
Subject: [PATCH 3/5] ARM: shmobile: r8a7791: Use SoC-specific 48-bit CMT
 compat string
In-Reply-To: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
References: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410136068-32220-4-git-send-email-horms+renesas@verge.net.au>
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
make use of the SoC-specific CMT compat string for the r8a7791 48-bit CMT
clock source.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8a07505..e06c11f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -193,7 +193,7 @@
 	};
 
 	cmt0: timer at ffca0000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -206,7 +206,7 @@
 	};
 
 	cmt1: timer at e6130000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.0.1
