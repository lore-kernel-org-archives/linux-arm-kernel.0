From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:27:44 +0900
Subject: [PATCH 1/5] ARM: shmobile: r8a7740: Use SoC-specific 48-bit CMT
 compat string
In-Reply-To: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
References: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410136068-32220-2-git-send-email-horms+renesas@verge.net.au>
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
make use of the SoC-specific CMT compat string for the r8a7740 48-bit CMT
clock source.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 1067a96..d46c213 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -42,7 +42,7 @@
 	};
 
 	cmt1: timer at e6138000 {
-		compatible = "renesas,cmt-48";
+		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
 		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
-- 
2.0.1
