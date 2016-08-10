From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 11:38:24 +0200
Subject: [PATCH 2/2] ARM: dts: add syscon compatible string for CP syscon
Message-ID: <1470821904-26008-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This syscon needs to be looked up by flash protection, CLCD
display output settings and other consumers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to fixes so we get
functional flash protection on the Integrator/CP.
---
 arch/arm/boot/dts/integratorcp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index d43f15b4f79a..79430fbfec3b 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -94,7 +94,7 @@
 	};
 
 	syscon {
-		compatible = "arm,integrator-cp-syscon";
+		compatible = "arm,integrator-cp-syscon", "syscon";
 		reg = <0xcb000000 0x100>;
 	};
 
-- 
2.7.4
