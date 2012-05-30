From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:23 +0800
Subject: [PATCH 05/22] ARM: ux500: PRCMU related configuration and layout
 corrections for Device Tree
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apply db8500 related PRCMU Device Tree settings and clean up some formatting
errors. We also remove one of the PRCMU assigned IRQs, as it is currently not
used.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 881bc39..7be77df 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -169,12 +169,12 @@
 		prcmu at 80157000 {
 			compatible = "stericsson,db8500-prcmu";
 			reg = <0x80157000 0x1000>;
-			interrupts = <46 47>;
+			interrupts = <0 47 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-				prcmu-timer-4 at 80157450 {
+			prcmu-timer-4 at 80157450 {
 				compatible = "stericsson,db8500-prcmu-timer-4";
 				reg = <0x80157450 0xC>;
 			};
-- 
1.7.9.5
