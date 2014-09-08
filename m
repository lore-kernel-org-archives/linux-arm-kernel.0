From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:57:07 +0900
Subject: [PATCH v3 2/3] ARM: shmobile: sh73a0: Use SoC-specific 48-bit CMT
 compat string
In-Reply-To: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
References: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410137828-4769-3-git-send-email-horms+renesas@verge.net.au>
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
make use of the SoC-specific CMT compat string for the sh73a0 48-bit CMT
clock source.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* First post
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 6cb29cd..030a592 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -49,7 +49,7 @@
 	};
 
 	cmt1: timer at e6138000 {
-		compatible = "renesas,cmt-48";
+		compatible = "renesas,cmt-48-sh73a0", "renesas,cmt-48";
 		reg = <0xe6138000 0x200>;
 		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.0.1
