From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 11:38:12 +0200
Subject: [PATCH 1/2] ARM: dts: add syscon compatible string for AP syscon
Message-ID: <1470821892-25957-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This syscon needs to be looked up by clocks, flash protection
and other consumers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to fixes so we have
functional flash protection on the Integrator/AP.
---
 arch/arm/boot/dts/integratorap.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 16266722ce7c..726a3ac486e0 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -43,7 +43,7 @@
 	};
 
 	syscon {
-		compatible = "arm,integrator-ap-syscon";
+		compatible = "arm,integrator-ap-syscon", "syscon";
 		reg = <0x11000000 0x100>;
 		interrupt-parent = <&pic>;
 		/* These are the logical module IRQs */
-- 
2.7.4
