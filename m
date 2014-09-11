From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:56:59 +0900
Subject: [PATCH 2/7] ARM: shmobile: r7s72100: Use SoC-specific MTU2 compat
 string
In-Reply-To: <cover.1410396171.git.horms+renesas@verge.net.au>
References: <cover.1410396171.git.horms+renesas@verge.net.au>
Message-ID: <f401ce481082de6327d12a8dc5528d2f7a4a4445.1410396171.git.horms+renesas@verge.net.au>
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
make use of the SoC-specific CMT compat string for the r7s72100 MTU2
clock source.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 1d28d01..801a556 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -230,7 +230,7 @@
 	};
 
 	mtu2: timer at fcff0000 {
-		compatible = "renesas,mtu2";
+		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
 		reg = <0xfcff0000 0x400>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "tgi0a";
-- 
2.0.1
