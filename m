From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 30 Nov 2012 15:24:59 +0000
Subject: [PATCH 1/1] ARM: ux500: Change IRQ from low-to-high edge triggered to
 high-to-low
Message-ID: <1354289099-17931-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the STMPE IRQ is triggered to be active high level-sensitive, the
Nomadik GPIO controller it uses complains, although it still works.
Recently we attempted to move triggering to low-to-high in an attempt
to prevent the warning; however, this ensured that the IRQ was actually
missed completely. Now we have a solution which both works and keeps the
GPIO controller happy.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stuib.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 39446a2..615392a 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -15,7 +15,7 @@
 			stmpe1601: stmpe1601 at 40 {
 				compatible = "st,stmpe1601";
 				reg = <0x40>;
-				interrupts = <26 0x1>;
+				interrupts = <26 0x2>;
 				interrupt-parent = <&gpio6>;
 				interrupt-controller;
 
-- 
1.7.9.5
