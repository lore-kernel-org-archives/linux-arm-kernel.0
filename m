From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon,  8 Oct 2018 22:48:50 +0200
Subject: [PATCH] DT: marvell,mmp2: fix the gpio interrupt cell number
Message-ID: <20181008204850.130161-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-pxa uses two cell to encode the interrupt source: the pin number
and the trigger type. Adjust the device node accordingly.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index f8867364e5a1..f2a18779de7c 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -180,7 +180,7 @@
 				clocks = <&soc_clocks MMP2_CLK_GPIO>;
 				resets = <&soc_clocks MMP2_CLK_GPIO>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				ranges;
 
 				gcb0: gpio at d4019000 {
-- 
2.19.0
